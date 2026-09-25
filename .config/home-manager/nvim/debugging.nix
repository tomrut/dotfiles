{
  config,
  pkgs,
  lib,
  vimUtils,
  ...
}:
{
  programs.nixvim.plugins = {
    dap-ui.settings.floating.mappings = {
      close = [
        "<ESC>"
        "q"
      ];
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    cmp-dap.enable = true;
    dap = {
      enable = true;
      extensions = {
      };
      signs = {
        dapBreakpoint = {
          text = "";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "";
          texthl = "DapBreakpointCondition";
        };
        dapLogPoint = {
          text = "";
          texthl = "DapLogPoint";
        };
      };
    };
    dap-lldb.enable = true;
    dap-python.enable = true;
  };

  # Allow DAP UI to automatically open and close when possible
  programs.nixvim.extraConfigLua = ''
    require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
    require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
    require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
  '';

  programs.nixvim.extraPlugins = [ (pkgs.vimPlugins.telescope-dap-nvim) ];
}
