# [0.4.0](https://github.com/99linesofcode/devshell-php/compare/v0.3.1...v0.4.0) (2026-03-25)


### Bug Fixes

* **dependabot:** time should be of type string instead of int ([ec34136](https://github.com/99linesofcode/devshell-php/commit/ec3413622e25418663ee052e520b1cead7d46a20))
* nixfmt-rfc-style is now the default nixfmt ([269594b](https://github.com/99linesofcode/devshell-php/commit/269594b94829dbc126fdac030f4f572c39d3f63f))
* **vale:** drop Google documentation styleguide ([27109dd](https://github.com/99linesofcode/devshell-php/commit/27109dda1e5b39eb99267c5d5f8c56e23ae27e6f))


### Features

* **github:** automatic updates and changelog generation ([83b7d9e](https://github.com/99linesofcode/devshell-php/commit/83b7d9eb33dea906dd5c0d5efaed6b9f995a7a24))
* **hadolint:** for linting docker files ([9d261c5](https://github.com/99linesofcode/devshell-php/commit/9d261c51a582829f18effdea8c314f5da16d4254))
* installed standalone linters for languages with lsps that don't handle it ([0195dc0](https://github.com/99linesofcode/devshell-php/commit/0195dc0fd5a33e6fe803e72804de2dcf6a93ba9f))
* **jsonlint:** for linting JSON files ([a911c55](https://github.com/99linesofcode/devshell-php/commit/a911c55808b67381c3ea1fea4ffe8624cfc75df7))
* **nvim:** configure relevant linters ([0b45325](https://github.com/99linesofcode/devshell-php/commit/0b45325eef50120643dfa2665a179444585e56e8))
* **phpstan:** for linting and static analysis of PHP files ([ae182ae](https://github.com/99linesofcode/devshell-php/commit/ae182ae61f188dfffece08e808dfb050213168c2))
* **playwright:** installs the headless browers used by pnpm exec playwright ([b3d74c4](https://github.com/99linesofcode/devshell-php/commit/b3d74c45ec16c6c03f8bb84212ab66a3e2b15b0b))
* **sqlite:** make sure sqlite is installed ([e46cb54](https://github.com/99linesofcode/devshell-php/commit/e46cb54a0d7f35ac38cd2ca2896baaa180dcefa3))
* use binary cache to speed up builds where possible ([4068fb1](https://github.com/99linesofcode/devshell-php/commit/4068fb1a69dab96596d5b25b46e43467b0712ec5))
* use shared .github-php submodule ([70d847c](https://github.com/99linesofcode/devshell-php/commit/70d847c3676a9c42dde2f2ad9737386ea98e9ffc))



## [0.3.1](https://github.com/99linesofcode/devshell-php/compare/v0.3.0...v0.3.1) (2025-06-10)


### Bug Fixes

* **nix:** make sure nixfmt is installed in case it's not present by default ([55a6d33](https://github.com/99linesofcode/devshell-php/commit/55a6d3392c637ccd869914595787482256879fdf))



# [0.3.0](https://github.com/99linesofcode/devshell-php/compare/v0.2.1...v0.3.0) (2025-05-19)


### Features

* **nix:** allow unfree packages ([20f043a](https://github.com/99linesofcode/devshell-php/commit/20f043a5782ca2380355b5828113f68c4d36f1b2))



## [0.2.1](https://github.com/99linesofcode/devshell-php/compare/v0.2.0...v0.2.1) (2025-04-18)


### Bug Fixes

* **composer:** expose global bin directory for running laravel/installer ([dfc7347](https://github.com/99linesofcode/devshell-php/commit/dfc73476c64b025c27b46c57949efd9539f8f58a))



# [0.2.0](https://github.com/99linesofcode/devshell-php/compare/v0.1.0...v0.2.0) (2025-04-18)


### Bug Fixes

* **xdebug:** start on trigger to prevent warnings in CLI output ([9c71b94](https://github.com/99linesofcode/devshell-php/commit/9c71b944ba58464df989a0ff90e6d1d1ed4fecc0))


### Features

* **phpactor:** install the language server locally ([552df09](https://github.com/99linesofcode/devshell-php/commit/552df0910c27a7e709177984666feabcd02db83c))



