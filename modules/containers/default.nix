{ pkgs, lib, ... }:

{
  imports = [ ./minecraft.nix ./jellyfin.nix ./immich.nix ];
}
