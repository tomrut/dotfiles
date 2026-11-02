{
  pkgs,
  ...
}:

{

  home.packages = with pkgs; [
    # reactjs development
    nodejs_24
    pnpm
  ];

}
