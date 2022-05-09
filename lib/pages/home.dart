
import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: 'Backstreet Boys', votes: 50),
    Band(id: "2", name: 'Metallica', votes: 4),
    Band(id: "3", name: 'Los Bukis', votes: 3),
    Band(id: "4", name: 'Grupo Ladron', votes: 4),
    Band(id: "5", name: 'Guns and Roses', votes: 2),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle( color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) {
          return _bandTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 1,

      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          child:  Text(band.name.substring(0,2)),
          backgroundColor: const Color.fromARGB(255, 160, 184, 204),
        ),
        title: Text(band.name),
        trailing: Text('${ band.votes }'),
        onTap: (){
          // ignore: avoid_print
          print(band.name);
        },
      ),
    );
  }

  addNewBand(){
    final textController =  TextEditingController();

    if (!Platform.isMacOS){
       showDialog(
        context: context, 
        builder: ( context ){
          return AlertDialog(
            title: const Text('New band name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: const Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text)
              ),
            ],
          );
        }
      );
    } else{
      showCupertinoDialog(
      context: context, 
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New Band name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );

    }
    
  }

  void addBandToList( String name ) {
    // ignore: avoid_print
    print(name);
    if(name.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 4 ));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }
}