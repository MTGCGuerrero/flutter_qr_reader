import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_mode.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor, id: 0, tipo: '');
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    var scans = await DBProvider.db.getTodosLosScans();
    scans = [...?scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    var scans = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...?scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAll();
    scans = [];
    notifyListeners();
  }

  borrarScanPorID(int id) async {
    await DBProvider.db.deleteScan(id);
    cargarScanPorTipo(tipoSeleccionado);
  }
}
