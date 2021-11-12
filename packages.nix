{ config, pkgs, ... }:

let
  user_name = "lukasz";
  # user_full_name = "";
  # user_description = "";
  user_packages = with pkgs; [
    awscli2
    broot
    cargo
    default_python
    ffmpeg
    git
    github-cli
    gnupg
# gnupg2
    jq
    kind
    kubernetes-helm
    magic-wormhole
    maven
    pass
    passExtensions.pass-otp
    pinentry
    pinentry_mac
    pwgen
    ranger
    rustc
    sshfs
# telepresence
    tree
    unixtools.watch
    vim
# virtualenvwrapper
    wget
    youtube-dl
# zulu # jdk-11 # fixed in https://github.com/NixOS/nixpkgs/pull/133806, waiting for the next release
  ];
  user_brew_formulae = [
    "docker"
    # "gimme-aws-creds"
    # "pass"
    # "pass-otp"
    # "pinentry-mac"
    # "vim"
  ];
  user_brew_taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];
  user_brew_casks = [
    "eloston-chromium"
    "firefox-developer-edition"
    "iterm2"
    "jetbrains-toolbox"
    "karabiner-elements"
    "lulu"
    "notion"
    "slack"
    "spotify"
    "temurin11" # replace with nix-pkgs install zulu?
    "zoom"
  ];
  gimme-aws-creds = ps: ps.callPackage ./gimme-aws-creds.nix { okta = (okta ps); ctap-keyring-device = (ctap-keyring-device ps); };
  ctap-keyring-device = ps: ps.callPackage ./ctap-keyring-device.nix {};
  okta = ps: okta: ps.callPackage ./okta.nix {};
  default_python = pkgs.python3.withPackages(ps: with ps; [
    pip
    virtualenvwrapper
# (gimme-aws-creds ps)
#    (okta ps)
   ]);
in {
  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    brews = user_brew_formulae;
    extraConfig = ''
      cask_args appdir: "~/Applications"
    '';
    taps = user_brew_taps;
    casks = user_brew_casks;
    # masApps = user_mas_apps;
  };

  users.users.${user_name} = {
    # description = "${user_description}";
    home = "/Users/${user_name}";
    # name = "${user_full_name}";
    packages = user_packages;
  };
}
