{ pkgs, ... }:
let inherit (pkgs) python3Packages;
in
{
  environment.systemPackages =
    let
      packages = pythonPackages:
        with pythonPackages; [
          flake8
          ipython
          isort
          pip-tools
          ptpython
          requests
        ];

      python = pkgs.python3.withPackages packages;

    in
    with pkgs; [
      autoflake
      python
    ];
}
