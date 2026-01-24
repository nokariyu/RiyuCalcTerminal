#!/data/data/com.termux/files/usr/bin/sh

echo "[+] Installing RiyuCalc..."

mkdir -p $PREFIX/share/riyucalc
cp RiyuCalc-1.0.jar $PREFIX/share/riyucalc/

cp riyucalc $PREFIX/bin/R
chmod +x $PREFIX/bin/R

echo "[✓] RiyuCalc installed!"
echo "Run with: R calc"
