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
    # ./lms.nix
  ];
}
