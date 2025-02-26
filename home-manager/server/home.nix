{ inputs, outputs, lib, config, pkgs, misterioFlake, ... }:
# You can import other home-manager modules here
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "main";
  });
in {

  imports = [ nixvim.homeManagerModules.nixvim ../shared/default.nix ];

  nixpkgs = { config = { allowUnfree = true; }; };

  home = {
    username = "sheep";
    homeDirectory = "/home/sheep";
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    git = {

      enable = true;
      userName = "Sheepheerd";
      userEmail = "130428152+Sheepheerd@users.noreply.github.com";
      extraConfig = { credential.helper = "oauth"; };
    };

    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      luaLoader.enable = true;
    };
  };
  systemd.user.startServices = "sd-switch";

}
