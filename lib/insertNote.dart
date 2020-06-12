import 'package:crud_mysql_php_flutter/fetchNotes.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import './config.dart';

class InsertNote extends StatefulWidget {
  @override
  _InsertNoteState createState() => _InsertNoteState();
}

class _InsertNoteState extends State<InsertNote> {
  TextEditingController controlTitle = new TextEditingController();
  TextEditingController controlConcept = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("AGREGAR NOTA"),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                controller: controlTitle,
                decoration: new InputDecoration(labelText: "Titulo"),
              ),
              new TextField(
                controller: controlConcept,
                decoration: new InputDecoration(labelText: "Concepto"),
              ),
              new RaisedButton(
                child: new Text("Agregar Nota"),
                onPressed: () {
                  var url = backend + "insertNote.php";
                  http.post(url, body: {
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
