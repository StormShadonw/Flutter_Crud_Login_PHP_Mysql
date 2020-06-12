import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import './config.dart';
import './updateNote.dart';
import './fetchNotes.dart';

class NoteDetails extends StatefulWidget {
  int index;
  List lista;

  NoteDetails({this.index, this.lista});

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("DETALLES DE LA NOTA"),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: Column(
            children: <Widget>[
              new Text(
                "Titulo: " + widget.lista[widget.index]['title'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              new Text(
                "ID Nota: " + widget.lista[widget.index]['id'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              new Text(
                "Concepto: " + widget.lista[widget.index]['concept'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              new RaisedButton(
                child: Text("EDITAR"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new UpdateNote(
                        lista: widget.lista,
                        index: widget.index,
                      ),
                    ),
                  );
                },
              ),
              new RaisedButton(
                child: Text("BORRAR"),
                onPressed: () {
                  var url = backend + "deleteNote.php";
                  http.post(url, body: {
                    "id": widget.lista[widget.index]['id']
                  }).whenComplete(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new FetchNotes()));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
