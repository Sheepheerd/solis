{ inputs, ... }: {
  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  age.secrets."immich.env" = {
    file = ./env/immich.age;
    owner = "sheep";
    group = "users";
  };
}
