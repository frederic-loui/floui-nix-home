# neovim

{ config, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox
      ];
 
      extraConfig = ''
        set t_Co=256
        set mouse-=a
        set paste
        set background=dark
        set number
        syntax on
        colorscheme gruvbox
      '';
    };
  };
}
