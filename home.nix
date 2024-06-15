{
  config,
  pkgs,
  stable-pkgs,
  inputs,
  ...
}: let
  candy = import ./candy.nix {inherit pkgs;};
in {
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

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
    sioyek

    nur.repos.nltch.spotify-adblock

    # stable-pkgs.steam
    # stable-pkgs.steam-run
    # stable-pkgs.steamPackages.steamcmd
    # inputs.steam-tui.packages."${pkgs.system}".steam-tui

    alejandra

    floorp
    firefox-devedition
    thunderbird
    pika-backup

    grimblast
    (import ./derivations/screenshot.nix {inherit pkgs;})
    mako
    wf-recorder
    (import ./derivations/recorder.nix {inherit pkgs;})
    rofi-wayland
    wl-clipboard
    swww
    pulsemixer
    fastfetch
    hyprcursor
    trashy
    viewnior
    hypridle
    hyprlock
    udiskie
    bottom
    cava
    hyprpicker
    mpv

    ripgrep
    fd
    sl
    zsh-fzf-tab

    pass-wayland
    gnupg
    pinentry-qt
    (import ./derivations/pass.nix {inherit pkgs;})

    at
    (import ./derivations/alarm.nix {inherit pkgs;})

    calibre
    libreoffice-fresh
    libqalculate
    transmission-qt
    gimp
    planify
    foliate

    jq
    socat
    hck

    emacs
    neovim
    obsidian
    zed-editor

    enchant
    nodejs_22
    pyright
    clang-tools

    catppuccin-qt5ct
    cinnamon.nemo-with-extensions

    texliveFull

    noto-fonts-emoji
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "Monaspace" "Mononoki"];})

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
    aliases = {
      lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg = "lg2";
    };
    delta = {
      enable = true;
    };
    extraConfig = {
      delta = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
        syntax-highlighting = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    shellAliases = {
      ll = "eza -l";
      update = "sudo nixos-rebuild switch --flake ~/flake_firestorm/";
      home-update = "home-manager switch";
      cd = "z";
      ls = "eza";
      rm = "trash -c always put";
      cat = "bat";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["sudo" "colored-man-pages"];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    history = {
      share = true;
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
    };

    initExtra = ''
      HISTDUP=erase
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS

      source ~/.p10k.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa $realpath'
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

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eww = {
    enable = true;
    configDir = ./filthy;
  };

  xdg.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "qt5ct-style";
      package = pkgs.catppuccin-qt5ct;
    };
  };

  catppuccin.flavor = "mocha";

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
