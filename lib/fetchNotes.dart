import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './config.dart';
import './insertNote.dart';
import './noteDetails.dart';


class FetchNotes extends StatefulWidget {
  @override
  _FetchNotesState createState() => _FetchNotesState();
}

class _FetchNotesState extends State<FetchNotes> {
  
  Future<List> fetchNotes() async {

    final response = await http.get(backend + "fetchNotes.php");
    print(json.encode(response.body));
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("LISTA DE NOTAS"),
      ),

      body: new FutureBuilder<List> (
        future: fetchNotes(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ElementoLista(
            lista: snapshot.data,
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),

      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context) => new InsertNote(),
            )
          ),
      ),
    );
  }
}

class ElementoLista extends StatelessWidget {

  final List lista;

  ElementoLista({ this.lista });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: new GestureDetector(
            onTap: () {

              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new NoteDetails(
                    index: posicion,
                    lista: lista,
                  ),
                )
              );
            },

            child: new Card(
              color: Colors.deepPurple,
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  lista[posicion]['id']+": "+lista[posicion]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}

