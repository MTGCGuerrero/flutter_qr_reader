import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_mode.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListNotifier extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor, id: 0, tipo: '');
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }
}
