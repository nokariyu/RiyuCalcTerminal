#!/bin/bash
set -e

echo "Installing RiyuCalc 2.0..."

# detect termux
IS_TERMUX=false
if [ -n "$PREFIX" ] && command -v pkg &> /dev/null; then
    IS_TERMUX=true
fi

# install dependencies
if ! command -v java &> /dev/null; then
    echo "Installing Java..."
    if $IS_TERMUX; then
        pkg install openjdk -y
    else
        sudo apt install default-jdk -y
    fi
fi

INSTALL_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.riyucalc"

mkdir -p "$INSTALL_DIR"
mkdir -p "$APP_DIR"

# download jar
echo "⬇ Downloading RiyuCalc..."
curl -L https://raw.githubusercontent.com/nokariyu/riyucalc/main/riyucalc.jar \
     -o "$APP_DIR/riyucalc.jar"

# launcher
cat << EOF > "$INSTALL_DIR/riyucalc"
#!/bin/bash
java -jar $APP_DIR/riyucalc.jar "\$@"
EOF

chmod +x "$INSTALL_DIR/riyucalc"

# add PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> ~/.bashrc
fi

echo "Installed!"
echo "Restart terminal, then type: riyucalc"
