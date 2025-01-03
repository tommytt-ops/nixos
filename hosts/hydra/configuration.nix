{ pkgs, inputs, username, home, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../../moduels/nixos/hydra.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users = {
	    users.${username} = {
	        isNormalUser = true;
	        extraGroups = [ "networkmanager" "docker" "wheel" ];
	};
  };

  virtualisation.docker.rootless = {
	  enable = true;
	  setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
	  vim 
   	wget
	  docker
	  binutils
	  gcc
	  docker-compose
	  ripgrep
  ];

  system.stateVersion = "24.05";
}
