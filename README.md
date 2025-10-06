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
## Installation with flake and home-manager
https://www.youtube.com/watch?v=2QjzI5dXwDY  
https://www.tonybtw.com/tutorial/nixos-from-scratch/
## Others
https://search.nixos.org/packages  
https://mynixos.com/

