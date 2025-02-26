{ pkgs, ... }: {

  # Specify the desired packages to install in the user environment.
  home.packages = with pkgs; [
    direnv
    git-credential-manager
    compose2nix
    git-credential-oauth
  ];
}
