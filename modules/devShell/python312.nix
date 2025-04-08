{ pkgs, lib, ... }:

{
 buildInputs = [
    pkgs.python312Packages.fastapi
    pkgs.python312Packages.flask
  ];
}