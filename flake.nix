{
  description = "Development environment configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
            # (final: prev: { nodejs = prev.nodejs_20; })
          ];
        };

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      formatter = forEachSystem (s: nixpkgs.legacyPackages.${s}.nixfmt);

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
              nodePackages.intelephense
              nodePackages.nodejs
              nodePackages.pnpm
              nodePackages.prettier_d_slim
              playwright # NOTE: this must match the version of playwright installed in pnpm. figure out how to properly link these.
              phpEnv
              phpEnv.packages.composer
              phpstan
            ];

            shellHook = ''
              export PATH="$(composer global config home)/vendor/bin:$PATH"
              export PATH="$PWD/node_modules/.bin/:$PATH"
              export PLAYWRIGHT_BROWSERS_PATH=${playwright.browsers}
              export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
              export PLAYWRIGHT_HOST_PLATFORM_OVERRIDE="ubuntu-24.04"
            '';
          };
        }
      );
    };
}
