{ pkgs, username, home, ... }:
{
    imports = [ 
    ];
 
    # Important
    home = {
	username = username; 
	homeDirectory = home;
	sessionVariables = {
	    EDITOR = "nvim";
	};
    };

    programs = { 
	alacritty.enable = true;
	fastfetch.enable = true;
	home-manager.enable = true; # Let Home Manager manage itself
    };

    # Bluetooth media controls
    services.mpris-proxy.enable = true;
    
    # The home.packages option allows you to install Nix packages into your environment.
    home.packages = with pkgs; [ 
    ];

    home.stateVersion = "24.05"; # Dont touch

}
