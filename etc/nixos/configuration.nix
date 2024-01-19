# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <musnix>
      /home/yottanami/src/noteditor/noteditor.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yotta-laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #  earlySetup = true;
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #services.xserver.layout = "us";
  #services.gvfs.enable = true;
  services.xserver.windowManager = {
    exwm.enable = true;
    noteditor.enable = true;
  };
  

  # Configure keymap in X11
  services.xserver.layout = "us,ir";
  services.xserver.xkbOptions = "ctrl:swapcaps,grp:alt_caps_toggle";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = false;
  # hardware.pulseaudio.enable = true;

 # services.jack = {
 #   jackd.enable = true;
 #   alsa.enable = false;
 #   loopback = {
 #     enable = true;
 #   };
 # };

 # users.extraUsers.yottanami.extraGroups = ["jackaudio"];
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  musnix.enable = true;

  users.groups.realtime = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yottanami = {
     isNormalUser = true;
     shell = pkgs.fish;
     extraGroups = [ "wheel" "audio" "realtime" "networkmanager"]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       vlc
       gimp
       alacritty
       dunst
       nomacs
       feh #Remove one of these image viewers
       flameshot
       gh
       brave
       git
       neofetch
       pavucontrol
       helvum #pipewire patchbay
       guitarix
       sonic-pi
       encfs
       weechat
       pavucontrol
       qjackctl 
       arandr
       webcamoid
       musescore
    ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     emacs # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     tldr
     spaceFM
     cifs-utils
     jmtpfs
     quickemu
     socat
     spice-gtk
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  programs.udevil.enable = true;
  programs.fish.enable = true;
  #security.wrappers."mount.cifs".source = "${pkgs.cifs-utils}/bin/mount.cifs";
  #security.wrappers."mount.cifs".setuid = true;
  #security.wrappers."mount.cifs".owner = "yottanami";
  #security.wrappers."mount.cifs".group = "root";
  nixpkgs.overlays = [ (final: prev: {
    udevil = prev.udevil.overrideAttrs (old: {
      postInstall = ''
      sed -i 's/^allowed_types =.*/allowed_types = \$KNOWN_FILESYSTEMS, file, cifs, nfs, curlftpfs, ftpfs, sshfs, davfs/' \
        $out/etc/udevil/udevil.conf
    '';
    });
  }) ];
  #services.gvfs.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  #pipewire bluetooth
  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
	};

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}

