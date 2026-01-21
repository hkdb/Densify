#!/bin/bash

#################################################################
### PROJECT:
### Densify
### VERSION:
### v0.4.0
### SCRIPT:
### install.sh
### DESCRIPTION:
### Install Script for Densify
### MAINTAINED BY:
### hkdb <hkdb@3df.io>
### Disclaimer:
### This application is maintained by volunteers and in no way
### do the maintainers make any guarantees. Use at your own risk.
### ##############################################################

set -e

VER="v0.14"
CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "
${GREEN}
░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░ ░▒▓███████▓▒░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░▒▓██████▓▒░  ░▒▓██████▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░

                                    INSTALLER

${NC}
"

# Detect OS
USEROS=""
echo -e "🐧️ Detecting OS..."
if [[ "$OSTYPE" == "linux"* ]]; then
  USEROS="linux"
  echo -e "\n🐧️ Linux\n"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  USEROS="freebsd"
  echo -e "\n🅱️  FreeBSD\n"
else
  echo -e "❌️ Operating System not supported... Exiting...\n"
  exit 1
fi

# Detect CPU architecture
echo -e "💻️ Detecting CPU arch...\n"

CPUARCH=""
UNAMEM=$(uname -m)
echo -e "🏰️: $UNAMEM\n"

if [[ "$UNAMEM" == "x86_64" ]] || [[ "$UNAMEM" == "amd64" ]]; then
  CPUARCH="amd64"
elif [[ "$UNAMEM" == "aarch64" ]] || [[ "$UNAMEM" == "arm64" ]]; then
  CPUARCH="arm64"
else
  echo -e "❌️ CPU Architecture not supported... Exiting...\n"
  exit 1
fi

# Detect distro type
detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID="$ID"
    DISTRO_LIKE="$ID_LIKE"
  elif [ -f /etc/debian_version ]; then
    DISTRO_ID="debian"
    DISTRO_LIKE="debian"
  elif [ -f /etc/redhat-release ]; then
    DISTRO_ID="rhel"
    DISTRO_LIKE="rhel"
  else
    DISTRO_ID="unknown"
    DISTRO_LIKE=""
  fi

  # Determine package manager type
  if [[ "$DISTRO_ID" == "debian" || "$DISTRO_ID" == "ubuntu" || "$DISTRO_ID" == "linuxmint" || "$DISTRO_ID" == "pop" || "$DISTRO_LIKE" == *"debian"* || "$DISTRO_LIKE" == *"ubuntu"* ]]; then
    PKG_TYPE="debian"
  elif [[ "$DISTRO_ID" == "fedora" || "$DISTRO_ID" == "rhel" || "$DISTRO_ID" == "centos" || "$DISTRO_ID" == "rocky" || "$DISTRO_ID" == "alma" || "$DISTRO_LIKE" == *"rhel"* || "$DISTRO_LIKE" == *"fedora"* ]]; then
    PKG_TYPE="redhat"
  elif [[ "$DISTRO_ID" == "arch" || "$DISTRO_ID" == "manjaro" || "$DISTRO_ID" == "endeavouros" || "$DISTRO_ID" == "cachyos" || "$DISTRO_LIKE" == *"arch"* ]]; then
    PKG_TYPE="arch"
  else
    PKG_TYPE="unknown"
  fi

  echo -e "📦️ Detected distro: $DISTRO_ID ($PKG_TYPE-based)\n"
}

# Check if a package is installed
check_gtk4_installed() {
  case $PKG_TYPE in
    debian)
      dpkg -l | grep -q "libgtk-4" && return 0 || return 1
      ;;
    redhat)
      rpm -q gtk4 &>/dev/null && return 0 || return 1
      ;;
    arch)
      pacman -Qi gtk4 &>/dev/null && return 0 || return 1
      ;;
    *)
      return 1
      ;;
  esac
}

check_libnotify_installed() {
  case $PKG_TYPE in
    debian)
      dpkg -l | grep -q "libnotify" && return 0 || return 1
      ;;
    redhat)
      rpm -q libnotify &>/dev/null && return 0 || return 1
      ;;
    arch)
      pacman -Qi libnotify &>/dev/null && return 0 || return 1
      ;;
    *)
      return 1
      ;;
  esac
}

check_ghostscript_installed() {
  command -v gs &>/dev/null && return 0 || return 1
}

check_python_gobject_installed() {
  case $PKG_TYPE in
    debian)
      dpkg -l | grep -q "python3-gi" && return 0 || return 1
      ;;
    redhat)
      rpm -q python3-gobject &>/dev/null && return 0 || return 1
      ;;
    arch)
      pacman -Qi python-gobject &>/dev/null && return 0 || return 1
      ;;
    *)
      return 1
      ;;
  esac
}

# Install dependencies
install_dependencies() {
  local missing_deps=()

  echo -e "🔍️ Checking dependencies...\n"

  if ! check_gtk4_installed; then
    missing_deps+=("gtk4")
    echo -e "  ${YELLOW}⚠️  GTK4 not found${NC}"
  else
    echo -e "  ${GREEN}✓${NC} GTK4 installed"
  fi

  if ! check_libnotify_installed; then
    missing_deps+=("libnotify")
    echo -e "  ${YELLOW}⚠️  libnotify not found${NC}"
  else
    echo -e "  ${GREEN}✓${NC} libnotify installed"
  fi

  if ! check_ghostscript_installed; then
    missing_deps+=("ghostscript")
    echo -e "  ${YELLOW}⚠️  GhostScript not found${NC}"
  else
    echo -e "  ${GREEN}✓${NC} GhostScript installed"
  fi

  if ! check_python_gobject_installed; then
    missing_deps+=("python-gobject")
    echo -e "  ${YELLOW}⚠️  Python GObject not found${NC}"
  else
    echo -e "  ${GREEN}✓${NC} Python GObject installed"
  fi

  echo ""

  if [ ${#missing_deps[@]} -eq 0 ]; then
    echo -e "${GREEN}All dependencies are installed!${NC}\n"
    return 0
  fi

  # Handle unknown distro
  if [ "$PKG_TYPE" == "unknown" ]; then
    echo -e "${RED}❌️ Unrecognized distribution.${NC}\n"
    echo -e "Please install the following dependencies manually before running this script again:\n"
    echo -e "  ${CYAN}• GTK4${NC} (and development files)"
    echo -e "  ${CYAN}• libnotify${NC}"
    echo -e "  ${CYAN}• GhostScript${NC}"
    echo -e "  ${CYAN}• Python GObject bindings${NC} (PyGObject)\n"
    echo -e "Example package names:"
    echo -e "  Debian/Ubuntu: libgtk-4-dev gir1.2-gtk-4.0 libnotify-bin ghostscript python3-gi"
    echo -e "  Fedora/RHEL:   gtk4-devel libnotify ghostscript python3-gobject"
    echo -e "  Arch Linux:    gtk4 libnotify ghostscript python-gobject\n"
    exit 1
  fi

  # Ask user if they want to install missing dependencies
  echo -e "The following dependencies are missing: ${YELLOW}${missing_deps[*]}${NC}\n"
  read -p "Would you like to install them now? [y/N] " -n 1 -r
  echo ""

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n${RED}❌️ Cannot proceed without dependencies. Exiting...${NC}\n"
    exit 1
  fi

  echo -e "\n📥️ Installing dependencies...\n"

  case $PKG_TYPE in
    debian)
      sudo apt-get update
      sudo apt-get install -y libgtk-4-dev gir1.2-gtk-4.0 libnotify-bin ghostscript python3-gi python3-gi-cairo
      ;;
    redhat)
      sudo dnf install -y gtk4-devel libnotify ghostscript python3-gobject python3-cairo
      ;;
    arch)
      sudo pacman -Sy --needed --noconfirm gtk4 libnotify ghostscript python-gobject python-cairo
      ;;
  esac

  echo -e "\n${GREEN}✓ Dependencies installed successfully!${NC}\n"
}

# Detect distro and check/install dependencies
detect_distro
install_dependencies

# Install Densify
echo -e "🚀️ Installing Densify...\n"
chmod +x densify
chmod +x densify.desktop
mkdir -p /opt/Densify
cp densify /opt/Densify
cp __init__.py /opt/Densify 2>/dev/null || true
cp *.png /opt/Densify
cp densify.desktop /usr/share/applications/

echo -e "\n${GREEN}**************"
echo -e " 💯️ COMPLETED"
echo -e "**************${NC}\n"

echo -e "Installation Complete. You are good to go! :)\n"
