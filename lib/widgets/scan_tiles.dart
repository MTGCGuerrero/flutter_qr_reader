import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorID(scanListProvider.scans[i].id);
        },
        child: ListTile(
            leading: Icon(
              tipo == 'http' ? Icons.map_outlined : Icons.home_max_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scanListProvider.scans[i].valor),
            subtitle: Text(scanListProvider.scans[i].id.toString()),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.amber,
            ),
            onTap: () => launchUrl(context, scanListProvider.scans[i])),
      ),
    );
  }
}
