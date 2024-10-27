import 'package:clubwampus/global/const.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:clubwampus/global_variables.dart';

class QRView extends StatefulWidget {
  final Function(String) showSnackBarQR; // Recibe la función

  const QRView({super.key, required this.showSnackBarQR});

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  Barcode? _barcode;
  bool _isCameraOn = true; // Estado de la cámara

  Widget _buildBarcode(Barcode? value) {
    String? displayValue;
    String? wmp;
    String? number;

    if (value == null) {
      return const Text(
        'Scan QR code',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    } else {
      displayValue = value.displayValue;
      // Separar el displayValue en dos variables
      if (displayValue != null && displayValue.contains('-')) {
        List<String> parts = displayValue.split('-');
        wmp = parts[0];
        number = parts[1];
        widget.showSnackBarQR('Bien!!! Ganaste $number Puntos');
        _isCameraOn = false;
      }
    }

    return Text(
      qrCodeData ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              children: <Widget>[
                // Mostrar MobileScanner solo si _isCameraOn es true
                if (_isCameraOn)
                  MobileScanner(
                    onDetect: _handleBarcode,
                  ),
                // La imagen ahora está arriba de _buildQrView
                Positioned.fill(
                  child: Image.asset(
                    'assets/wallpapers/fondo-qr.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 100,
                    color: Colors.black.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: _buildBarcode(_barcode))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
