#!/data/data/com.termux/files/usr/bin/sh
set -e

APP_NAME="RiyuCalc"
APP_DIR="$PREFIX/share/riyucalc"
BIN_NAME="riyuc"
REPO_RAW="https://raw.githubusercontent.com/nokariyu/RiyuCalcTerminal/main"

if ! command -v java >/dev/null 2>&1; then
  echo "[!] Java not found."
  echo "[!] Please install Java 21 or newer."
  exit 1
fi

# 2. ambil versi java (major)
JAVA_VERSION=$(java -version 2>&1 | sed -n 's/.*"\([0-9]\+\).*/\1/p')

echo "[*] Detected Java version: $JAVA_VERSION"

if [ "$JAVA_VERSION" -ge 24 ]; then
  JAR_PATH="versions/jdk24"
elif [ "$JAVA_VERSION" -ge 21 ]; then
  JAR_PATH="versions/jdk21"
else
  echo "[!] Java version too old."
  echo "[!] Minimum supported version is Java 21."
  exit 1
fi

echo "[*] Using JAR: $JAR_PATH"

install_version() {
  VERSION="$1"
  JAR_NAME="RiyuCalc-$VERSION.jar"

  echo "[*] Installing $APP_NAME $VERSION"

  mkdir -p "$APP_DIR"

  curl -fsSL "$REPO_RAW/$JAR_PATH/$JAR_NAME" \
    -o "$APP_DIR/$JAR_NAME"

  cat > "$PREFIX/bin/$BIN_NAME" <<EOF
#!/data/data/com.termux/files/usr/bin/sh
exec java -jar "$APP_DIR/$JAR_NAME" "\$@"
EOF

  chmod +x "$PREFIX/bin/$BIN_NAME"

  echo "[✓] Installed $APP_NAME $VERSION"
  echo "Run with: $BIN_NAME"
}

case "$1" in
  v1.0)
    
    install_version "1.0"
    ;;
  v1.1)
    
    install_version "1.1"
    ;;
  latest|"")
    
    install_version "1.1"
    ;;
  *)
    echo "Usage:"
    echo "  sh install.sh v1.0"
    echo "  sh install.sh v1.1"
    echo "  sh install.sh latest"
    exit 1
    ;;
esac
