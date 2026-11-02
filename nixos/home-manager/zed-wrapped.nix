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
    package = pkgs.zed-editor.fhsWithPackages (
      pkgs: with pkgs; [
        typescript-language-server
        nixd
        nil
        vscode-json-languageserver
        vscode-html-languageserver
        vscode-css-languageserver
        tailwindcss-language-server
        yaml-language-server
      ]
    );

    userSettings = {
      lsp = {
        # rust-analyzer = {
        #   binary = {
        #     # path = lib.getExe pkgs.rust-analyzer;
        #     path_lookup = true;
        #   };
        # };

      };

    };
  };

  xdg.dataFile."applications/dev.zed.Zed.desktop" = {
    force = true;

    text =
      builtins.replaceStrings
        [ "Exec=zeditor" ]
        [
          "Exec=${config.home.profileDirectory}/bin/nixGLIntel ${config.home.profileDirectory}/bin/zeditor"
        ]
        (builtins.readFile "${pkgs.zed-editor}/share/applications/dev.zed.Zed.desktop");
  };

}
