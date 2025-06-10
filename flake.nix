{
  description = "Development environment configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      pkgsForSystem =
        system: nixpkgsSource:
        import nixpkgsSource {
          inherit system;
          config.allowUnfree = true;
          overlays = [
          ];
        };

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      formatter = forEachSystem (s: nixpkgs.legacyPackages.${s}.nixfmt-rfc-style);

      devShells = forEachSystem (
        s:
        let
          pkgs = pkgsForSystem s nixpkgs;
          phpEnv = pkgs.php.buildEnv {
            extensions = (
              { enabled, all }:
              enabled
              ++ (with all; [
                xdebug
              ])
            );
            extraConfig = ''
              xdebug.mode = debug
              xdebug.start_with_request = trigger
            '';
          };
        in
        with pkgs;
        {
          default = mkShell {
            packages = [
              nixfmt-rfc-style
              markdownlint-cli2
              nodePackages.intelephense
              nodePackages.nodejs
              nodePackages.pnpm
              phpEnv
              phpEnv.packages.composer
              vale
              valeStyles.alex
              valeStyles.google
              valeStyles.proselint
            ];

            shellHook = ''
              export PATH="$(composer global config home)/vendor/bin:$PATH"
              export PATH="$PWD/node_modules/.bin/:$PATH"
            '';
          };
        }
      );
    };
}
