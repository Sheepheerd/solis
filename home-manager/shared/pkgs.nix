{ pkgs, ... }: {

  # Specify the desired packages to install in the user environment.
  home.packages = with pkgs; [
    direnv
    compose2nix

    #Utils
    file
    git
    git-credential-oauth
    git-credential-manager
    ripgrep
    macchina
    jq
    zoxide
    fzf
    bat
    mdcat
    ouch

  ];
}
