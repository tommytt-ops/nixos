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
    shellAliases = {
        tf_i = "terraform init";
        tf_aa = "terraform apply --auto-approve";
        tf_p = "terraform paln";
        tf_d = "terraform destroy";
        tf_da = "terraform destroy --auto-approve";
    };
    };

    programs = { 
	    alacritty.enable = true;
	    fastfetch.enable = true;
	    home-manager.enable = true; # Let Home Manager manage itself
        bash.enable = true;
    };

    # Bluetooth media controls
    services.mpris-proxy.enable = true;
    
    # The home.packages option allows you to install Nix packages into your environment.
    home.packages = with pkgs; [ 
    ];

    home.stateVersion = "24.05"; # Dont touch
}
