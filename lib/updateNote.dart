import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './config.dart';
import './fetchNotes.dart';

class UpdateNote extends StatefulWidget {
  final List lista;
  int index;

  UpdateNote({this.lista, this.index});

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController controlTitle;
  TextEditingController controlConcept;
  @override
  void initState() {
    super.initState();
    controlTitle =
        new TextEditingController(text: widget.lista[widget.index]['title']);
    controlConcept =
        new TextEditingController(text: widget.lista[widget.index]['concept']);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("EDITAR NOTA"),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("ID: " + widget.lista[widget.index]['id']),
              new TextField(
                controller: controlTitle,
                decoration: new InputDecoration(
                  labelText: "Titulo",
                ),
              ),
              new TextField(
                controller: controlConcept,
                decoration: new InputDecoration(labelText: "Concepto"),
              ),
              new RaisedButton(
                child: Text("Editar Nota"),
                onPressed: () {
                  var url = backend + "updateNote.php";
                  http.post(url, body: {
                    "id": widget.lista[widget.index]['id'],
                    "title": controlTitle.text,
                    "concept": controlConcept.text,
                  }).whenComplete(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FetchNotes();
                        },
                      ),
                    );
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
