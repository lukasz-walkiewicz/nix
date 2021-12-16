1. [Install nix](https://nixos.org/download.html)

2. [Install nix-darwin](https://github.com/LnL7/nix-darwin#install)

3. Remove default `~./nixpkgs` and replace it with this repo:

```bash
rm -rf ~/.nixpkgs
git clone git@github.com:lukasz-walkiewicz/nix.git ~/.nixpkgs
```

4. Rebuild and switch:

```bash
darwin-rebuild switch
```

