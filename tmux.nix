# tmux

{ config, pkgs, ... }:

{
  programs = {
    tmux = {
    enable = true;
    shortcut = "a";
    aggressiveResize = true;
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;

    extraConfig = ''
      set-option -g mouse on
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      '';
    };
  };
}
