# sway

{ config, pkgs, ... }:

let

  start-sway = pkgs.writeShellScriptBin "start-sway" ''
    # first import environment variables from the login manager
    systemctl --user import-environment
    # then start the service
    exec systemctl --user start sway.service
  '';

  start-waybar = pkgs.writeShellScriptBin "start-waybar" ''
    export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -f 'sway$').sock
    ${pkgs.waybar}/bin/waybar
  '';

in {

     home.packages = with pkgs; [
       start-sway
     ]; 

  systemd.user.services.sway = {
    Unit = {
      Description = "Sway - Wayland window manager";
      Documentation = [ "man:sway(5)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.sway}/bin/sway";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  systemd.user.services.flashfocus = {
    Unit = {
      Description = "Flashfocus";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.flashfocus}/bin/flashfocus";
      RestartSec = 5;
      Restart = "always";
    };
  };


# Put this for swaylock in /etc/nixos/configuration.nix !!!
#
# security.pam.services.swaylock = {
#    text = ''
#      auth include login
#    '';
#  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config.input = { "*" = { xkb_layout = "fr,us"; }; 
                     "2:7:SynPS/2_Synaptics_TouchPad" = { tap = "enabled"; natural_scroll = "enabled";  }; };
    
    config.output = { "*" = { bg = "~/Downloads/kevin-mueller-Y6pJ3aq9f4Q-unsplash.jpg fill"; }; };
    
    config.terminal = "alacritty";
    config.menu = "wofi --width 200 --style ~/style.css --show run --allow-images --allow-markup --insensitive --define print_command=true | sed -n -e 's/\(.*\)%.*/\1/p' | xargs swaymsg exec --";

    config.left = "n";
    config.right = "e";
    config.up = "i";
    config.down = "o";

    config.bars = [{
        position = "top";
    }];

    config.keybindings = 
      let
        mod = config.wayland.windowManager.sway.config.modifier;
        inherit (config.wayland.windowManager.sway.config)
          left right up down menu terminal;
      in
      {
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+d" = "exec ${menu}";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
#        "${mod}+0" = "workspace number 10";

        "${mod}+Control+1" = "move container to workspace number 1";
        "${mod}+Control+2" = "move container to workspace number 2";
        "${mod}+Control+3" = "move container to workspace number 3";
        "${mod}+Control+4" = "move container to workspace number 4";
        "${mod}+Control+5" = "move container to workspace number 5";
        "${mod}+Control+6" = "move container to workspace number 6";
        "${mod}+Control+7" = "move container to workspace number 7";
        "${mod}+Control+8" = "move container to workspace number 8";
        "${mod}+Control+9" = "move container to workspace number 9";
#        "${mod}+Control+0" = "move container to workspace number 10";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+ Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+h" = "split h";
        "${mod}+v" = "split v";

        "${mod}+Shift+s" = "exec swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+v" = ''mode "system:  [r]eboot  [p]oweroff  [l]ogout"'';

        # switch workspace next/prev -> right/left

        "ctrl+Alt+Right" = "workspace next_on_output";
        "ctrl+Alt+Left" = "workspace prev_on_output";

        # Brightness
        "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +2%";

        # Volume
        "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
        "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
        "XF86AudioMute" = "exec pamixer --toggle-mute";

      };
  };
}
