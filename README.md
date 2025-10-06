# NixOS
Testing the meme v2.

# Commands
## run after changing config
`sudo nixos-rebuild dry-run --flake ~/dotfiles-nixos#nix-vm`

`sudo nixos-rebuild switch --flake ~/dotfiles-nixos#nix-vm`

## update packages
not sure yet, sth. that worked when pointing to `nixpkgs/nixos-unstable` in `flake.nix`:

### sudo apt update
cd into `dotfiles-nixos`, then:
`nix flake update`
### sudo apt upgrade
after this, do the *dry-run* from above to see changes
or the *switch* to apply them

# Links
## CLI Installation with flake and home-manager
https://www.youtube.com/watch?v=2QjzI5dXwDY  
https://www.tonybtw.com/tutorial/nixos-from-scratch/
## Others
https://search.nixos.org/packages  
https://mynixos.com/

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

3. git clone *dotfiles*, *dotfiles-nixos* and *scripts*, then `cp /etc/nixos/hardware-configuration.nix ~/dotfiles-nixos/` 

4. add this LUKS line from `/etc/nixos/configuration.nix` to `~/dotfiles-nixos/configuration.nix`

boot.initrd.luks.devices... = "/dev/disk/by-uuid/..."

5. `sudo nixos-rebuild switch --flake ~/dotfiles-nixos#nix-vm` 

