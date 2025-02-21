{ pkgs, inputs, ... }: {
  imports = [ ./server/default.nix ./dev/default.nix ./containers/default.nix ];
}
