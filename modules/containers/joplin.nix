{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."joplin-app" = {
    image = "joplin/server:latest";
    environment = {
      "APP_BASE_URL" = "http://solis:22300";
      "APP_PORT" = "22300";
      "DB_CLIENT" = "pg";
      "POSTGRES_DATABASE" = "joplin";
      "POSTGRES_HOST" = "db";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_PORT" = "5432";
      "POSTGRES_USER" = "postgres";
    };
    ports = [ "22300:22300/tcp" ];
    dependsOn = [ "joplin-db" ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=app" "--network=joplin_default" ];
  };
  systemd.services."podman-joplin-app" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-joplin_default.service" ];
    requires = [ "podman-network-joplin_default.service" ];
    partOf = [ "podman-compose-joplin-root.target" ];
    wantedBy = [ "podman-compose-joplin-root.target" ];
  };
  virtualisation.oci-containers.containers."joplin-db" = {
    image = "postgres:15";
    environment = {
      "POSTGRES_DB" = "joplin";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
    };
    volumes =
      [ "/mnt/one-t-ssd/joplin-server/postgres:/var/lib/postgresql/data:rw" ];
    ports = [ "100.113.25.38:5432:5432/tcp" ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=db" "--network=joplin_default" ];
  };
  systemd.services."podman-joplin-db" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-joplin_default.service" ];
    requires = [ "podman-network-joplin_default.service" ];
    partOf = [ "podman-compose-joplin-root.target" ];
    wantedBy = [ "podman-compose-joplin-root.target" ];
  };

  # Networks
  systemd.services."podman-network-joplin_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f joplin_default";
    };
    script = ''
      podman network inspect joplin_default || podman network create joplin_default
    '';
    partOf = [ "podman-compose-joplin-root.target" ];
    wantedBy = [ "podman-compose-joplin-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-joplin-root" = {
    unitConfig = { Description = "Root target generated by compose2nix."; };
    wantedBy = [ "multi-user.target" ];
  };
}
