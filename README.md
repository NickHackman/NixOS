<div align="center">
  <img src="https://nixos.org/logo/nix-wiki.png" alt="NixOS Icon">
  <h1>Git Detective</h1>

  <p>
    <strong>NickHackman's Personal NixOS configuration.</strong>
  </p>

  <p>
  </p>
</div>

## Installation

- Move all files into `/etc/nixos`
- Edit [`boot-configuration`](./boot-configuration.nix)
  - Change `initrd.luks.devices.root.device`
  - Change `boot.kernelParams`

## Further Configuration

[Nix Manual](https://nixos.org/nix/manual/)

[NixOS Manual](https://nixos.org/nixos/manual/)

## Dotfiles

For my dotfiles, they are [here](https://github.com/NickHackman/dotfiles)
