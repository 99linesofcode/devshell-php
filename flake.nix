{
  description = "Development environment configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs23.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs23,
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
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "nodejs-14.21.3"
              "openssl-1.1.1w"
            ];
          };
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
          pkgs23 = pkgsForSystem s nixpkgs23;
          phpEnv = pkgs.php83.buildEnv {
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
              # Nix
              nil
              nixfmt-rfc-style

              # Markdown
              markdownlint-cli2

              # NodeJS
              nodePackages.intelephense
              pkgs23.nodejs_14
              # nodePackages.pnpm

              # PHP
              phpEnv
              phpEnv.packages.composer

              # Prose
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
