{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1280x1080";
#  boot.initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/$UUID";
#  networking.hostName = "$HOSTNAME";
  networking.useDHCP = false;
#  networking.interfaces.$INTERFACE.useDHCP = true;
#  time.timeZone = "$TIMEZONE";
  programs.sway.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    flatpak sway wireguard openvpn
    p11-kit # Flatpak has a dependency on this for some CA stuff
  ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde pkgs.xdg-desktop-portal ];
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.pcscd.enable = true;
  programs = {
     gnupg.agent.enable = true;
     gnupg.agent.enableSSHSupport = true;
  };
  services.openssh.enable = true;
#  networking.firewall.allowedTCPPorts = [ 80 443 ];
#  networking.firewall.allowedUDPPorts = [];
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  programs.fish.enable = true;
  users.users.etcaton = {
      isNormalUser = true;
      home = "/home/etcaton";
      extraGroups = [ "audio" "wheel" "networkmanager" "sway" ];
      packages = with pkgs; [
          alacritty asciinema anki
          bitwarden bat
          cargo cargo-update cmake cowsay curl crystal clippy
          ddrescue docker du-dust
          exa elixir
          fd fish firefox-devedition-bin fortune fzf ffmpeg
          gcc git go gimp gnupg
          imagemagick image_optim
          kubectl kubernetes-helm htop handbrake hexyl hyperfine
          jq
          libfido2 libressl llvm libreoffice
          musl magic-wormhole mpv minikube maven makemkv
          nano neovim neofetch neomutt nodejs
          openssh jdk14
          paperkey python pinentry-curses
          ripgrep rustup rustfmt rsync rls redshift-wlr
          swaybg swayidle swaylock starship shfmt shellcheck signal-desktop
          traceroute topgrade tor-browser-bundle-bin transmission tmux
          ungoogled-chromium
          vscodium
          waybar wofi wget wabt wasm-pack
          youtube-dl
          slack discord # Flatpak depends on p11 for certs and seems to have an issue. TODO: Remove these dependencies
      ];
      shell = pkgs.fish;
  };
  system.stateVersion = "20.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}
