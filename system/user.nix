{pkgs, opt-config, ...}:
let
  name = opt-config.username;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${name} = {
    isNormalUser = true;
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "video" 
      "libvirtd" 
      "docker"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
}
