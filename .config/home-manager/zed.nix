{
  pkgs,
  lib,
  config,
  ...
}:

{

  programs.zed-editor = {
    enable = true;

    userSettings = {
      project_panel = {
        dock = "left";
      };

      base_keymap = "JetBrains";
      ui_font_size = 16;
      buffer_font_size = 16;
      max_tabs = 6;

      theme = {
        mode = "dark";
        light = "Ayu Light";
        dark = "Ayu Dark";
      };

      theme_overrides = {
        editor.document_highlight.bracket_background = "#ff0001";
      };

      telemetry = {
        # Send debug info like crash reports.
        diagnostics = false;
        # Send anonymized usage data like what languages you're using Zed with.
        metrics = false;
        # Allow sending requests to Anthropic models that cannot be offered with
        # Zero Data Retention
        anthropic_retention = false;
      };

      node = {
        path = lib.getExe pkgs.nodejs_24;
        npm_path = lib.getExe' pkgs.nodejs "pnpm";
      };

      lsp = {
        # rust-analyzer = {
        #   binary = {
        #     # path = lib.getExe pkgs.rust-analyzer;
        #     path_lookup = true;
        #   };
        # };

        jdtls = {
          settings = {
            java_home = "${pkgs.jdk21}";
            lombok_support = true;
            jdk_auto_download = false;
            min_memmory = "1G";
            max_memmory = "2G";

            initialization_options = {
              settings = {
                java = {
                  configuration = {
                    runtimes = [
                      {
                        name = "JavaSE-21";
                        path = "${pkgs.jdk21}";
                        default = true;
                      }
                    ];
                  };
                };
              };
            };
          };
        };

        nixd = {
          binary = {
            path_lookup = true;
          };
        };

      };

      languages = {
        "Java" = {
          language_servers = [ "jdtls" ];
        };

        "Nix" = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--filename"
                "{buffer_path}"
              ];
            };
          };
        };
      };
    };

    extensions = [
      "nix"
      "html"
      "tsgo"
      "java"
      # react-typescript-snippets
    ];

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
