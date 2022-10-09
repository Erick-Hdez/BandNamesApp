import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Porcupine Tree', votes: 6),
    Band(id: '2', name: 'Tool', votes: 5),
    Band(id: '3', name: 'Pink Floyd', votes: 4),
    Band(id: '4', name: 'King Crimson', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.3,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print('direction: $direction');
        print('band: ${band.id}');
        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 5),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: ListTile(
              leading: Icon(
                Icons.delete_sweep,
                color: Colors.white,
              ),
              title: Text(
                'Delete Band',
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          // print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final TextEditingController textController = TextEditingController();

    if (!Platform.isAndroid) {
      // Andorid
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name: '),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                elevation: 1,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add'),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New band name: '),
          content: CupertinoTextField(controller: textController),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => addBandToList(textController.text),
              child: const Text('Add'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('Dismiss'),
            )
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      // Agregar nombre
      bands.add(Band(id: '${bands.length + 1}', name: name));

      setState(() {});
    }

    // Salir del dialogo
    Navigator.pop(context);
  }
}
