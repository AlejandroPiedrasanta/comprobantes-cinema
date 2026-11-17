#!/bin/bash
# Crea "GENERADOR/INSTALADOR/Comprobantes Cinema (Mac).dmg" con la app lista para arrastrar a Aplicaciones.
# Uso en la Mac: abre Terminal, escribe  bash  (con un espacio), arrastra este archivo y pulsa Enter.
set -e
cd "$(dirname "$0")"
RAIZ="$(cd .. && pwd)"

if ! command -v python3 >/dev/null 2>&1; then
  echo "Falta Python 3. Instálalo desde https://www.python.org/downloads/macos/ y vuelve a ejecutar este archivo."
  exit 1
fi

echo "[1/4] Preparando entorno de Python (solo la primera vez tarda)..."
VENV="$HOME/Library/Caches/comprobantes-cinema-venv"
python3 -m venv "$VENV"
source "$VENV/bin/activate"
python -m pip install --quiet --upgrade pip
python -m pip install --quiet PySide6 PySide6-Fluent-Widgets Pillow pyinstaller

echo "[2/4] Empaquetando la app..."
python -m PyInstaller --noconfirm --clean --distpath dist-mac --workpath build-mac comprobantes.spec

echo "[3/4] Creando el instalador .dmg..."
TMP="$(mktemp -d)"
cp -R "dist-mac/Comprobantes Cinema.app" "$TMP/"
ln -s /Applications "$TMP/Aplicaciones"
SALIDA="$(cd "$RAIZ/.." && pwd)/INSTALADOR"
mkdir -p "$SALIDA"
DMG="$SALIDA/Comprobantes Cinema (Mac) 2.1.0.dmg"
rm -f "$DMG"
hdiutil create -volname "Comprobantes Cinema" -srcfolder "$TMP" -ov -format UDZO "$DMG" >/dev/null
rm -rf "$SALIDA/Comprobantes Cinema.app"
cp -R "dist-mac/Comprobantes Cinema.app" "$SALIDA/"   # la app lista para abrir sin instalar
rm -rf "$TMP" dist-mac build-mac

echo "[4/4] Listo:"
echo "  $DMG"
echo
echo "Para instalar: abre el .dmg y arrastra «Comprobantes Cinema» a Aplicaciones."
echo "La primera vez ábrelo con clic derecho > Abrir (la app no está firmada por Apple)."
