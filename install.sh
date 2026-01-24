#!/data/data/com.termux/files/usr/bin/sh

set -e

APP_NAME="RiyuCalc"
APP_DIR="$PREFIX/share/riyucalc"
BIN_NAME="R"

echo "[*] Installing $APP_NAME..."

if ! command -v java >/dev/null 2>&1; then
  echo "[!] Java not found. Installing OpenJDK..."
  pkg install -y openjdk-17
fi

mkdir -p "$APP_DIR"

cp RiyuCalc-1.0.jar "$APP_DIR/"

cp R "$PREFIX/bin/$BIN_NAME"
chmod +x "$PREFIX/bin/$BIN_NAME"

echo "[✓] $APP_NAME installed successfully!"
echo "Run with: $BIN_NAME calc"