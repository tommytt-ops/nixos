{ pkgs, inputs, username, home, ... }:
{

  nix.settings.experimental-features = [ "nix-command" "flakes"]
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/hydra.nix
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
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  #Install firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
