#!/data/data/com.termux/files/usr/bin/sh
set -e

APP_NAME="RiyuCalc"
APP_DIR="$PREFIX/share/riyucalc"
BIN_NAME="rc"
REPO_RAW="https://raw.githubusercontent.com/nokariyu/RiyuCalcTerminal/main"

echo "[*] Installing $APP_NAME..."

if ! command -v java >/dev/null 2>&1; then
  echo "[!] Java not found. Installing OpenJDK..."
  pkg install -y openjdk-17
fi

mkdir -p "$APP_DIR"

echo "[*] Downloading program files..."
curl -fsSL "$REPO_RAW/RiyuCalc-1.1.jar" -o "$APP_DIR/RiyuCalc-1.1.jar"
curl -fsSL "$REPO_RAW/rc" -o "$PREFIX/bin/$BIN_NAME"

chmod +x "$PREFIX/bin/$BIN_NAME"

echo "[✓] $APP_NAME installed successfully!"
echo "Run with: $BIN_NAME"
