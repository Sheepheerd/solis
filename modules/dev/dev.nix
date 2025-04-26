{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Bare minimum
    lemonade
    file
    git
    git-ignore
    gitleaks
    git-secrets
    git-credential-manager
    pass-git-helper

  ];
}
