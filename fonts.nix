# fonts cache update eg:fc-list

{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
    };
  }; 
}
