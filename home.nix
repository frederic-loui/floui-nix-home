{ config, pkgs, ... }:
let
  imports = [
    ./fonts.nix
    ./sway.nix
    ./tmux.nix
    ./neovim.nix
    ./git.nix
    ./alacritty.nix
    ./bash.nix
    ./firefox.nix
    ./neomutt.nix
  ];
in {
  inherit imports;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "floui";
  home.homeDirectory = "/home/floui";

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
  };  

#  wayland.windowManager.sway = {
#    enable = true;
#    wrapperFeatures.gtk = true;
#    config.input = { "*" = { xkb_layout = "fr"; }; };
#    config.terminal = "alacritty";
#  };

  home.packages = with pkgs; [
    swaylock-effects
    swayidle
    wl-clipboard
    wshowkeys
    mako
    wofi
    flashfocus
    brightnessctl
    pamixer
    dejavu_fonts
    nerdfonts
    mc
    ranger
    killall
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
