#!/data/data/com.termux/files/usr/bin/sh
set -e

APP_NAME="RiyuCalc"
APP_DIR="$PREFIX/share/riyucalc"
BIN_NAME="riyuc"
REPO_RAW="https://raw.githubusercontent.com/nokariyu/RiyuCalcTerminal/main"

install_java() {
  if ! command -v java >/dev/null 2>&1; then
    echo "[*] Java not found, installing OpenJDK 17..."
    pkg install -y openjdk-17
  fi
}

install_version() {
  VERSION="$1"
  JAR_NAME="RiyuCalc-$VERSION.jar"

  echo "[*] Installing $APP_NAME $VERSION"

  mkdir -p "$APP_DIR"

  curl -fsSL "$REPO_RAW/versions/$VERSION/$JAR_NAME" \
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
    install_java
    install_version "1.0"
    ;;
  v1.1)
    install_java
    install_version "1.1"
    ;;
  latest|"")
    install_java
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
