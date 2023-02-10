import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_mode.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)?.settings.arguments as ScanModel;
    return Scaffold(
      body: Center(
        child: Text(scan.valor.toString()),
      ),
    );
  }
}
