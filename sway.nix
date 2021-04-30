# sway

{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config.input = { "*" = { xkb_layout = "fr"; }; 
                     "2:7:SynPS/2_Synaptics_TouchPad" = { tap = "enabled"; natural_scroll = "enabled";  }; };
    
    config.output = { "*" = { bg = "~/Downloads/kevin-mueller-Y6pJ3aq9f4Q-unsplash.jpg fill"; }; };
    
    config.terminal = "alacritty";
    config.menu = "wofi --width 200 --style ~/style.css --show run --allow-images --allow-markup --insensitive --define print_command=true | sed -n -e 's/\(.*\)%.*/\1/p' | xargs swaymsg exec --";

    config.left = "n";
    config.right = "e";
    config.up = "i";
    config.down = "o";

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

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+v" = ''mode "system:  [r]eboot  [p]oweroff  [l]ogout"'';
      };
  };
}
