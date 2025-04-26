{ pkgs, lib, ... }:

{
  imports = [
    ./minecraft.nix
    ./jellyfin.nix
    ./immich.nix
    ./gitea.nix
    ./joplin.nix
    ./linkwarden.nix
    ./romm.nix
    ./radicale.nix
    ./grocy.nix
    # ./lms.nix
  ];
}
