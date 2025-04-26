{
  services.radicale = {
    enable = true;
    settings = {
      server = { hosts = [ "100.113.25.38:5232" ]; };
      auth = { type = "none"; };
      storage = { filesystem_folder = "/mnt/one-t-ssd/radicale/collections"; };
    };
  };
  systemd.tmpfiles.rules =
    [ "d /mnt/one-t-ssd/radicale/collections 0750 radicale radicale -" ];
}
