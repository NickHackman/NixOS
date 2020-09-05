<div align="center">
  <img src="https://nixos.org/logo/nix-wiki.png" alt="NixOS Icon">
  <h1>NixOS Config</h1>

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

## Nix Shells

There are Fish aliases for `nix-shell` for certain coding environments listed in [shells](./shells). These are specifically setup to provide requirements for [doom-emacs](https://github.com/hlissner/doom-emacs).

- [x] C/C++
- [x] Python
- [x] Nix
- [x] Markdown
- [x] Node
- [X] Rust
- [ ] Golang
- [ ] Ruby

These shells can be used with [lorri](https://github.com/target/lorri) and direnv - via shell aliases for init in [fish config](./configs/fish.nix).

## Further Configuration

[Nix Manual](https://nixos.org/nix/manual/)

[NixOS Manual](https://nixos.org/nixos/manual/)

## Dotfiles

For my dotfiles, they are [here](https://github.com/NickHackman/dotfiles)
