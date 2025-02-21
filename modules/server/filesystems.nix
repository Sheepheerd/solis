{

  fileSystems."/export/hdd" = {
    device = "/mnt/hdd";
    options = [ "bind" ];

  };
  fileSystems."/export/sdd" = {
    device = "10.147.17.9:/hdd/Plex/media";
    fsType = "nfs";

    options = [
      "x-systemd.idle-timeout=20"
    ]; # disconnects after 10 minutes (i.e. 600 seconds)
  };
}
