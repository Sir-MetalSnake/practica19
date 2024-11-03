import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:practica19/ui/list_tile.dart';

class ListviewPage extends StatelessWidget {
  var datos;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practica 19 - API'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF422C),
      ),
      body: FutureBuilder(
          future: _llamarURL(),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            try {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var datos = snapshot.data![index];
                    return MyListTile(
                      titulo: datos['name'],
                      subtitulo: datos['gender'],
                      imagenfin: datos['image'],
                    );
                  });
            } catch (exc) {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List> _llamarURL() async {
    var url =
        "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10,20,183";
    final respuesta = await get(Uri.parse(url));
    final _respuestajson = json.decode(respuesta.body);
    return _respuestajson;
  }
}
