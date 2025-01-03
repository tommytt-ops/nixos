{ ... }:

{

services.hydra = {
    enable = true;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost"; 
    useSubstitutes = true;
    buildMachinesFiles = [];
  };
  
}