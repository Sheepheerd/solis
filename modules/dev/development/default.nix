{ pkgs, inputs, ... }: {
  imports = [ ./programming-languages.nix ./terminal-utils.nix ./direnv.nix ];

  nix.extraOptions = ''
    trusted-users = root sheep
  '';
}
