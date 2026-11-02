{
  pkgs,
  config,
  ...
}:

{

  imports = [
    ./zed-settings.nix
  ];

  home.packages = with pkgs; [

    # necessary for zed editor

    # nix development
    nil
    nixd
    nixfmt

    # typescript development
    typescript-language-server
    tailwindcss-language-server
    vscode-html-languageserver
    vscode-css-languageserver
    vscode-js-debug
    yaml-language-server
    jdt-language-server
  ];

  programs.zed-editor = {
    enable = true;
  };
}
