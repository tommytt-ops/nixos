# nixos

## nixos-anywhere on azure

1. setup azure linux vm using terraform/vm
2. clone 
3. edit disk-config, ssh public key to configuration.nix
4. nix run nixpkgs#nixos-anywhere -- --flake .#generic --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <usesr>@<ip>