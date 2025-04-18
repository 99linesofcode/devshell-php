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

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      formatter = forEachSystem (s: nixpkgs.legacyPackages.${s}.nixfmt-rfc-style);

      devShells = forEachSystem (
        s:
        with nixpkgs.legacyPackages.${s};
        let
          phpEnv = php.buildEnv {
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
        {
          default = mkShell {
            packages = [
              markdownlint-cli2
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
              export PATH="$PWD/node_modules/.bin/:$PATH"
            '';
          };
        }
      );
    };
}
