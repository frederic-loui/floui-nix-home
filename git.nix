# git

{ config, pkgs, ... }:

{
  programs = {
    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "Frederic LOUI";
      userEmail = "frederic.loui@renater.fr";
      aliases = {
        co = "checkout";
        ci = "commit";
      };

      ignores = [ "!*.nix" "*" ];
    };
  };
}
