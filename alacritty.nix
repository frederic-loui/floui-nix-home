# alacritty

{ config, pkgs, ... }:

{
  programs = {
    alacritty = {
    enable = true;
      settings = {
        font.normal = {
          family = "SauceCodePro Nerd Font";
          style = "Regular";
        };

        font.bold = {
          family = "SauceCodePro Nerd Font";
          style = "Bold";
        };

        font.italic = {
          family = "SauceCodePro Nerd Font";
          style = "Italic";
        };

        font.size = 9.0;
        
        background_opacity = 0.8;
      };
    };
  };
}
