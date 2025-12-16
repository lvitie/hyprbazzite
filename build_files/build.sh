#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# Install Noctalia Shell dependencies via COPR
dnf5 -y copr enable errornointernet/quickshell
dnf5 -y copr enable zhangyi6324/noctalia-shell
dnf5 -y copr enable solopasha/hyprland

# Install packages
dnf5 install -y \
    hyprland \
    xdg-desktop-portal-hyprland \
    waybar \
    kitty \
    niri \
    dotnet-sdk-8.0 \
    clang \
    cmake \
    quickshell \
    tmux \
    noctalia-shell 

# Disable COPRs to keep base image clean (optional, keeping enabled for updates might be desired, but standard practice is often to disable if not signed properly, though here we might leave them enabled or rely on user preference. I'll disable for safety/cleanliness unless they are needed for runtime updates). 
# Actually, for OSTree images, existing repos are usually kept for updates. I will comment out disabling.
# dnf5 -y copr disable errornointernet/quickshell
# dnf5 -y copr disable zhangyi6324/noctalia-shell

# Enable any services if needed (none strictly for these, maybe portal but that's DBus activated)
systemctl enable podman.socket