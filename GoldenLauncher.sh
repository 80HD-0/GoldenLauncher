#!/bin/bash
LWJGL_VERSION="2.9.3"
BETA_VERSION="1.7.3"

show_help() {
  echo "GoldenLauncher"
  echo "Usage: $0 [-h|--help] [-u|--uninstall]"
  echo
  echo "Options:"
  echo "  -u, --uninstall Uninstall GoldenLauncher"
  echo "  -h, --help      Show this help message"
  echo "  -v, --version   Choose which beta version to run (default 1.7.3)"
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -u|--uninstall)
      ./GoldenLauncherUninstaller.sh
      exit 0
      ;;
    -v|--version)
      shift
      BETA_VERSION="$1"
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
find_java_8() {
 
  # List all installed Java versions using update-alternatives
  JAVA_PATHS=$(update-alternatives --list java 2>/dev/null)

  if [[ -z "$JAVA_PATHS" ]]; then
    echo "No Java installations found using update-alternatives."
    return 1
  fi

  # Search for Java 8 in the list of paths
  for JAVA in $JAVA_PATHS; do
    JAVA_VERSION=$("$JAVA" -version 2>&1 | head -n 1)
    if [[ "$JAVA_VERSION" == *"1.8"* ]]; then
      echo "Found Java 8 at: $JAVA"
      JAVA_BIN="$JAVA"
      return 0
    fi
  done
  
  echo "Java 8 not found!"
  return 1
}

WORKDIR="$BETA_VERSION"

set -e

mkdir -p "$WORKDIR"
cd "$WORKDIR"
COLOR="\033[0;33m"

if ! find_java_8; then
  echo "Error: Java 8 is required for most beta minecraft versions. Please install it and try again."
  exit 1
fi

echo -e "${COLOR}******************"
echo -e "GOLDENLAUNCHER 0.1"
echo -e "******************"

if [ ! -e beta_$BETA_VERSION.jar ]; then
	# Download Minecraft
	echo "Downloading Minecraft Beta $BETA_VERSION..."
	wget -O beta_$BETA_VERSION.jar https://sourceforge.net/projects/minecraftversions/files/Beta/beta_$BETA_VERSION.jar/download
fi
if [ ! -e lwjgl.zip ]; then
	# Download LWJGL
	echo "Downloading LWJGL $LWJGL_VERSION..."
	wget -O lwjgl.zip https://sourceforge.net/projects/java-game-lib/files/Official%20Releases/LWJGL%20$LWJGL_VERSION/lwjgl-$LWJGL_VERSION.zip/download
	echo "Extracting LWJGL..."
	unzip -o lwjgl
	mv "lwjgl-$LWJGL_VERSION" lwjgl
fi

# Set up lib/natives
mkdir -p lib natives

cp lwjgl/jar/lwjgl.jar lib/
cp lwjgl/jar/lwjgl_util.jar lib/
cp lwjgl/jar/jinput.jar lib/

cp lwjgl/native/linux/*64.so natives/

# Launch the game
echo "Launching Minecraft Beta $BETA_VERSION..."
"$JAVA_BIN" -Djava.library.path=natives -cp "beta_$BETA_VERSION.jar:lib/lwjgl.jar:lib/lwjgl_util.jar:lib/jinput.jar" net.minecraft.client.Minecraft
