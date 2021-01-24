{ pkgs, ... }:
let inherit (pkgs) python3Packages;
in
{
  environment.systemPackages =
    let
      packages = pythonPackages:
        with pythonPackages; [
          ipython
          pip-tools
          ptpython
          requests
        ];

      python = pkgs.python3.withPackages packages;

    in
    [ python ];
}