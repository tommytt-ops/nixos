{ config, pkgs, ... }:
{
  # 1. Enable PostgreSQL
  services.postgresql.enable = true;
  services.postgresql.initialScript = ''
    CREATE USER hydra WITH PASSWORD 'hydrapass';
    CREATE DATABASE hydra;
    GRANT ALL PRIVILEGES ON DATABASE hydra TO hydra;
  '';

  # 2. Enable Hydra
  services.hydra = {
    enable = true;

    # This is the base URL Hydra will use in its UI and links
    hydraURL = "http://localhost:3000";

    # Let Hydra use substitutes (binary caches) so you don’t build everything from scratch
    useSubstitutes = true;

    # Hydra, by default, references /etc/nix/machines for remote builders
    # If you don't have such a file or don't plan to use remote builders, you can unset it:
    buildMachinesFiles = [];

    # We'll run on port 3000 (instead of the default 3001).
    # The hydra module does this by setting:
    listenAddress = "127.0.0.1";
    extraOptions = "--port 3000";

    # Telling Hydra explicitly about the PostgreSQL DB (optional if you go with defaults)
    database = {
      type = "postgresql";
      host = "/run/postgresql";  # local socket
      database = "hydra";
      user = "hydra";
      password = "hydrapass";
    };
  };
}
