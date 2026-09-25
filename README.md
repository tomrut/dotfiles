# Dot files and scripts used on Linux

## Nixos configuration
There are three nixos configurations + common modules
1. laptop
2. desktop
3. server
4. common - shared modules
- sway
- mounting
- podman
- monitoring
5. home-manager - the common part used by laptop and desktop
- nixvim.nix
- home-laptop.nix
- home-desktop.nix
- home.nix - home config shared between laptop and desktop
6. nixos-server - small nix server with samba and sshd for storing and sharing data

## Useful Nixos commands
``
  sudo nixos-rebuild switch --no-write-lock-file --flake .#nixos-laptop
``

## TPM2 for Luks 
``


  sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p3

  sudo dracut -fv --regenerate-all
  sudo update-grub
  
  # /etc/crypttab not changed
  sudo apt install tpm2-tools dracut
  added to /etc/grub/default not sure if necessary, especially this rd.luks=1, seems awakward
  GRUB_CMDLINE_LINUX="rd.auto rd.luks=1"

  # added following file: /etc/dracut.conf.d/99-crypt-tpm.conf
  add_dracutmodules+=" crypt systemd tpm2-tss lvm "
  install_items+=" /etc/crypttab /etc/fstab /lib/systemd/system-generators/systemd-cryptsetup-generator /lib/systemd/systemd-cryptsetup "
  hostonly="no"
  
``


# Neovim
## Shortcuts
[[nvim quick reference][ https://neovim.io/doc/user/quickref.html]]

| Shortcut | What does                                                       |
| CTRL-]   | jump to the tag under cursor - e.g. JSX component can be opened |
| CTRL-O   | go to Nth older position in jump list - go back in history      |
| CTRL-I   | go to Nth newer position in jump list - go next in history      |

# Linux
## Useful Commands
``
touch -d "$(date -R -r /$HOME/last_backup.marker) - 10 days" /$HOME/last_backup.marker

find . -empty -type d -delete
# mv the files from subdirectories preserving the directory names in the filename separated by -
find . -name \*.mp3 -exec sh -c 'new=$(echo "{}" | tr "/" "-" | cut -c 3-); mv "{}" "$new"' \;

perl -MFile::Path -we '
    for my $file (glob "*.mp3") {
        my ($artist, $album, $title) = split /-/, $file, 3;
        mkpath "$artist";
        my $new = "$artist/$album - $title";
        rename $file, $new or die "$file -> $new: $!\n";
    }'

 # enables fstrim for luks
 # this introduce some security risk - see man a for details
sudo cryptsetup refresh --allow-discards --persistent luks-7219f85c-a0e5-4085-a00d-da8871b69144
``
