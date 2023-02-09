import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: 10,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.map,color: Theme.of(context).primaryColor,),
        title: Text('poner alo despues'),
        subtitle: Text('ID:1'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.amber,),
        onTap: () => null,
      ), );
  }
}
