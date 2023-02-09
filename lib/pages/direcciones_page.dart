import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';



class DireccionesPage extends StatelessWidget {
  const DireccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          Icons.map,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scanListProvider.scans[i].valor),
        subtitle: Text(scanListProvider.scans[i].id.toString()),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.amber,
        ),
        onTap: () => print(scanListProvider.scans[i].id),
      ),
    );
  }
}