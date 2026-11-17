# Comprobantes · Cinema Productions

Programa de escritorio (Windows y Mac) para crear los comprobantes de pago de Cinema Productions:
llenas los datos del cliente, eliges el paquete (Esencial, Intermedio, Completo o Premium), subes la
captura de la transferencia y genera el JPG listo para WhatsApp. Lleva el historial de clientes,
saldos y abonos.

- Interfaz: PySide6 (Qt 6) + PySide6-Fluent-Widgets.
- Edición de las plantillas PSD: **PhotoCraft** (`photocraft-cli`), que debe estar instalado.
- Historial: SQLite local.

## Fuentes

Las fuentes del diseño (**Lemon Milk**, **GetVoIP Grotesque** y **Myriad Pro**) no están en este
repositorio por sus licencias. Al abrir el programa, si faltan, ve a *Ajustes › Fuentes del diseño*
y elige la carpeta donde están los archivos `.otf`.

## Compilar

- **Mac**: GitHub Actions (`.github/workflows/mac.yml`) crea el `.dmg` en cada cambio.
  También se puede compilar en una Mac con `empaquetar/CREAR APP MAC.command`.
- **Windows**: `empaquetar/CREAR INSTALADOR WINDOWS.bat` crea el portable y el instalador.

## Probar

```
python generador.py                        # abre el programa
python generador.py --verificar            # arma la interfaz sin mostrarla
python generador.py --autoprueba INFORME   # genera un comprobante de cada paquete
```
