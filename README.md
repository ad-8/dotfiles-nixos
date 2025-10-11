# NixOS
Testing the meme v2.

# Commands
## run after changing config
`sudo nixos-rebuild dry-run --flake ~/dotfiles-nixos#ax-mac`

`sudo nixos-rebuild switch --flake ~/dotfiles-nixos#ax-mac`


# update packages
not 100% sure, but this works so far

## sudo apt update
1. `cd ~/dotfiles-nixos`
2. `nix flake update` 

## sudo apt upgrade
- *dry-run* to see changes
- *switch* to apply them

# collect garbage
1. `sudo nix-collect-garbage -d`
2. `sudo nixos-rebuild switch --flake ~/dotfiles-nixos#ax-mac` (to remove the old generations from the boot menu)

# Annoyances
- while modularizing the config, `nixos-rebuild` does *not* find a new file if it exists, but is *untracked* in the git repo  
  (this cost me an hour to find out LULZ)


# Links
## CLI Installation with flake and home-manager
- https://www.youtube.com/watch?v=2QjzI5dXwDY
- https://www.tonybtw.com/tutorial/nixos-from-scratch/
## Others
- https://search.nixos.org/packages
- https://wiki.nixos.org/wiki/NixOS_Wiki
- https://nixos.wiki/
- https://mynixos.com/


# GUI Installation with LUKS -> convert to flake config
Install via Graphical ISO Image, which has a fast and easy Calamares installer 
with optional LUKS setup.

Tested with GNOME as DE in LiveDVD+Installation, then converted to the OG flake-config like so:
1. Add line to `/etc/nixos/configuration.nix`:
```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Also add `git` and `vim` to pkgs for the next steps.

2. `sudo nixos-rebuild switch`

3. git clone *dotfiles*, *dotfiles-nixos* and *scripts*, then `cp /etc/nixos/hardware-configuration.nix ~/dotfiles-nixos/hosts/<host>/` 

4. if NOT using LUKS, skip this step  
    add this LUKS line from `/etc/nixos/configuration.nix` to `~/dotfiles-nixos/configuration.nix`

    `boot.initrd.luks.devices... = "/dev/disk/by-uuid/..."`

5. `sudo nixos-rebuild switch --flake ~/dotfiles-nixos#ax-vm` 


# Breakage Counter = 1
How often did we need to revert back to an older generation to recover basically fatal errors
# Total Breakage Counter = 0
This better never reaches 1


