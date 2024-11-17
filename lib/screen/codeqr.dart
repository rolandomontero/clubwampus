import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

    if (value == null) {
      return const Text(
        'Acerca la cámara\nal código QR',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
             textAlign: TextAlign.center,
      );
    } else {
      displayValue = value.displayValue;
      // Separar el displayValue en dos variables
      if (displayValue != null && displayValue.contains('-')) {
        List<String> parts = displayValue.split('-');
        if(parts[0]=='wmp') {
           widget.showSnackBarQR(parts[1]);
        _isCameraOn = false;
        }
       
      }
    }

    return Text(
      'Ingresa un código Válido',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
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
                    alignment: Alignment.topCenter,
                    height: 120,
                    color: Colors.black.withOpacity(0.7),
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
