import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_mode.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: ((db) {}),
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )

''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO Scans( id, tipo, valor)
    VALUES ('$id', '$tipo', '$valor')
''');
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel?> getScanByID(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  Future<List<ScanModel>?> getScansPorTipo(String Tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
SELECT * FROM Scans WHERE tipo = '$Tipo'
''');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  // Eliminar registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }
}
