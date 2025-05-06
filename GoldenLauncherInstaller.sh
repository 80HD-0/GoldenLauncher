#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
  INSTALLDIR="/usr/local/bin/GoldenLauncher"
else
  INSTALLDIR="$HOME/.local/bin/GoldenLauncher"
fi

# Help message
show_help() {
  echo "GoldenLauncher Installer"
  echo "Usage: $0 [-d install_dir] [-h|--help]"
  echo
  echo "Options:"
  echo "  -d <dir>       Set custom installation directory"
  echo "  -h, --help     Show this help message"
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d)
      shift
      INSTALLDIR="$1"
      ;;
    -h|--help)
      show_help
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      ;;
  esac
  shift
done

rm -rf "$INSTALLDIR"
rm -f "$HOME/.local/share/applications/GoldenLauncher.desktop"
rm -f "$HOME/.local/share/applications/GoldenLauncherUninstaller.desktop"
rm -f GoldenLauncherUninstaller.sh
rm -f "$HOME/.local/bin/goldenlauncher"

mkdir "$INSTALLDIR"
cp GoldenLauncher.sh "$INSTALLDIR"
chmod +x "$INSTALLDIR/GoldenLauncher.sh"
cp icon.png "$INSTALLDIR"

if [ "$(id -u)" -eq 0 ]; then
  LINKDIR="/usr/share/applications"
else
  LINKDIR="$HOME/.local/share/applications"
fi


cat > "$LINKDIR/GoldenLauncher.desktop" <<EOF
[Desktop Entry]
Name=GoldenLauncher
Comment=GoldenLauncher 0.1 Beta Minecraft Launcher
Exec=$INSTALLDIR/GoldenLauncher.sh
Icon=$INSTALLDIR/icon.png
Terminal=false
Type=Application
Categories=Game;
EOF
cat > "$LINKDIR/GoldenLauncherUninstaller.desktop" <<EOF
[Desktop Entry]
Name=Uninstall GoldenLauncher
Comment=Uninstall GoldenLauncher 0.1
Exec=$INSTALLDIR/GoldenLauncherUninstaller.sh
Icon=$INSTALLDIR/icon.png
Terminal=true
Type=Application
Categories=Utility;
EOF

cat > "GoldenLauncherUninstaller.sh" <<EOF
#!/bin/bash
echo "Uninstalling GoldenLauncher"
rm -rf "$INSTALLDIR"
rm -f "$HOME/.local/share/applications/GoldenLauncher.desktop"
rm -f GoldenLauncherUninstaller.sh
rm -f "$HOME/.local/bin/goldenlauncher"
echo "Successfully Removed!"
EOF
cp ./GoldenLauncherUninstaller.sh "$INSTALLDIR"

mkdir -p "$HOME/.local/bin"

ln -sf "$INSTALLDIR/GoldenLauncher.sh" "$HOME/.local/bin/goldenlauncher"

chmod +x GoldenLauncherUninstaller.sh
chmod +x "$INSTALLDIR/GoldenLauncherUninstaller.sh"

echo GoldenLauncher successfully installed! You can find it in $INSTALLDIR or your installer menu.
