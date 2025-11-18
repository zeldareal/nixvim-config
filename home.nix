{
  config,
  pkgs,
  nixvim,
  spicetify-nix,
  ...
}:
{

  imports = [
    nixvim.homeModules.default
    ./modules/nixvim
    spicetify-nix.homeManagerModules.default

  ];
  #im sorry for writing this
  home.username = "zelda";
  home.homeDirectory = "/home/zelda";
  home.stateVersion = "25.05";
  # welcome to the fucking zelda verse where everything is #SWAGMESSIAH x100
  # Packages for your user
  home.packages = with pkgs; [

    chromium
    librewolf
    google-chrome
    fish
    starship
    wezterm
    fastfetch
    hyfetch
    lolcat
    sl
    onefetch
    bat
    eza
    fd
    fzf
    ripgrep
    zoxide
    btop
    mpv
    fuzzel
    notion-app-enhanced
    legcord
    prismlauncher
    gcc
    gnumake
    appimage-run
    pipewire
    fortune

  ];

  # ==PROGRAM CONFIGS== #
  programs.wezterm = {
    enable = true;
    extraConfig = ''
           return {
           color_scheme = 'Tokyo Night Storm',
      window_close_confirmation = 'NeverPrompt',

      }
    '';
  };

  #starship
  # programs.starship = {
  # enable = true;
  # enableFishIntegration = true;
  # settings = builtins.fromTOML (builtins.readFile ./dotfiles/starship.toml);
  # };

  # ==SPICETIFY== #
  programs.spicetify = {
    enable = true;
    theme = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.text;
    colorScheme = "TokyoNightStorm";
    enabledExtensions =
      with spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock
        shuffle
      ];
  };

  # ===ZELLIJ=== #
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "tokyo-night-storm";
      default_shell = "fish";
      show_startup_tips = false;

    };
  };

  programs.floorp = {
    enable = true;
  };

  #fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  #z
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  #firefox
  programs.firefox.enable = true;

  #git
  programs.git = {
    enable = true;
    extraConfig = {
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };

  #===FISH===
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];

    interactiveShellInit = ''
       set fish_greeting
      fortune -s | lolcat
    '';
    shellAliases = {
      ll = "eza -l --icons --git --group-directories-first";
      la = "eza -la --icons --git";
      lt = "eza -T --icons";
      ls = "eza --icons";
      cat = "bat";
      top = "btop";
      grep = "rg";
      find = "fd";
      tree = "eza -T --icons";
      lsg = "eza -la --icons --git --group-directories-first"; # the max eye candy one
      nhup = "nh os switch --update";
    };
    functions = {

      him = ''
        nvim /etc/nixos/home.nix
      '';
      fim = ''
        nvim /etc/nixos/flake.nix
      '';
      cim = ''
        nvim /etc/nixos/configuration.nix
      '';
      nvims = ''
        cd /etc/nixos/
        sudo -E nvim $argv
      '';
    };

  };
}
