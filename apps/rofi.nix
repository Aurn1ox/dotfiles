{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.overrideAttrs
      (oldAttrs: { mesonFlags = [ "-Dxcb=disabled" ]; });
    extraConfig = {
      modi = "drun";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      terminal = "foot";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = true;
      font = "FantasqueSansMono Nerd Font 14";
      display-drun = " Apps";
      drun-display-format = "{name}";
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg-col = mkLiteral "#303446";
        bg-col-light = mkLiteral "#303446";
        border-col = mkLiteral "#414559";
        selected-col = mkLiteral "#303446";
        sky = mkLiteral "#99d1db";
        fg-col = mkLiteral "#c6d0f5";
        fg-col2 = mkLiteral "@sky";
        grey = mkLiteral "#737994";

        width = mkLiteral "450px";
      };

      "element-text, element-icon , mode-switcher" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "window" = {
        height = mkLiteral "500px";
        border = mkLiteral "3px";
        border-radius = mkLiteral "15px";
        border-color = mkLiteral "@border-col";
        background-color = mkLiteral "@bg-col";
      };

      "mainbox" = { background-color = mkLiteral "@bg-col"; };

      inputbar = {
        children = mkLiteral "[prompt,entry]";
        background-color = mkLiteral "@bg-col";
        border-radius = mkLiteral "15px";
        padding = mkLiteral "2px";
      };

      prompt = {
        background-color = mkLiteral "@sky";
        padding = mkLiteral "6px";
        text-color = mkLiteral "@bg-col";
        border-radius = mkLiteral "15px";
        margin = mkLiteral "20px 0px 0px 20px";
      };

      textbox-prompt-colon = {
        expand = false;
        str = ":";
      };

      entry = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 10px";
        text-color = mkLiteral "@fg-col";
        background-color = mkLiteral "@bg-col";
      };

      listview = {
        border = mkLiteral "0px 0px 0px";
        padding = mkLiteral "6px 0px 0px";
        margin = mkLiteral "10px 0px 0px 20px";
        columns = 1;
        lines = 10;
        background-color = mkLiteral "@bg-col";
      };

      element = {
        padding = mkLiteral "5px";
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@fg-col";
      };

      element-icon = { size = mkLiteral "25px"; };

      "element selected" = {
        background-color = mkLiteral "@selected-col";
        text-color = mkLiteral "@fg-col2";
      };

      mode-switcher = { spacing = 0; };

      button = {
        padding = mkLiteral "10px";
        background-color = mkLiteral "@bg-col-light";
        text-color = mkLiteral "@grey";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };

      "button selected" = {
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@sky";
      };
    };
  };
}
