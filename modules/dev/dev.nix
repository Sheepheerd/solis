{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Bare minimum
    file
    git
    git-ignore
    gitleaks
    git-secrets
    git-credential-manager
    pass-git-helper

  ];
}
