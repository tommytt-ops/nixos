{ pkgs, lib, ... }:

{
 buildInputs = [
    pkgs.python311Packages.numpy
    pkgs.python311Packages.pandas
    pkgs.python311Packages.matplotlib
  ];
}
