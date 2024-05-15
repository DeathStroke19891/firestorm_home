{ config, pkgs, stable-pkgs, inputs, ... }:
let
  candy = import ./candy.nix { inherit pkgs; };
in
{

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.xremap-flake.homeManagerModules.default
    ./features/mako.nix
    ./features/hyprland.nix
    ./features/alacritty.nix
    ./features/hyprlock.nix
    ./features/hypridle.nix
    ./features/hyprshade.nix
  ];

  services.xremap = {
    enable = true;
    withWlroots = true;
    config = {
      modmap = [
        {
          name = "main remaps";
          remap = {
            "rightalt" = "rightmeta";
            CapsLock = {
              held = "leftctrl";
              alone = "esc";
              alone_timeout_millis = 150;
            };
          };
        }
      ];
    };
  };

  home.username = "parzival";
  home.homeDirectory = "/home/parzival";

  home.stateVersion = "23.11"; 
  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    lf
    sioyek
    nur.repos.nltch.spotify-adblock
    stable-pkgs.steam
    stable-pkgs.steam-run
    stable-pkgs.steamPackages.steamcmd
    inputs.steam-tui.packages."${pkgs.system}".steam-tui
    floorp
    protonvpn-cli
    alejandra
    pika-backup
    grimblast
    mako
    wf-recorder
    rofi-wayland
    wl-clipboard
    firefox-devedition
    thunderbird
    swww
    pulsemixer
    fastfetch
    hyprcursor
    trashy
    pass-wayland
    gnupg
    pinentry-qt
    calibre
    viewnior
    libreoffice-fresh
    libqalculate
    hypridle
    hyprlock
    jq
    socat
    hck
    udiskie
    emacs
    neovim
    bottom
    catppuccin-qt5ct
    cava
    hyprpicker
    mpv
    transmission-qt
    gimp
    obsidian
    ripgrep
    zed-editor
    fd
    cinnamon.nemo-with-extensions
    texliveFull
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Monaspace" "Mononoki"]; })

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    STEAM_APP_DIR = "/home/parzival/.local/share/Steam/steamapps/common/";
  };

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.git = {
    enable = true;
    userName = "Sridhar D Kedlaya";
    userEmail = "sridhardked@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      ll = "eza -l";
      update = "sudo nixos-rebuild switch --flake ~/flake_firestorm/";
      home-update = "home-manager switch";
      cd = "z";
      ls = "eza";
      rm = "trash -c always put";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "sudo" "git" "zoxide" "colored-man-pages" "ripgrep" "systemd"];
      theme = "alanpeabody";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''
	   source ~/.p10k.zsh
   ''; 
  };
  
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eww = {
    enable = true;
    configDir = ./filthy;
  };

  xdg.enable = true;

  qt= {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "qt5ct-style";
      package = pkgs.catppuccin-qt5ct;
    };
  };

  catppuccin.flavour = "mocha";

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "lavender";
      size = "standard";
    };

    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";

    iconTheme.package = pkgs.candy-icons;
    iconTheme.name = "candy-icons";
  };
}
