import 'package:flutter/material.dart';

class CharacterDetailsPage extends StatelessWidget {
  final dynamic character;

  CharacterDetailsPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Mostrar la imagen del personaje en el contenido de la página
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  character['thumbnail']['path'] +
                      '.' +
                      character['thumbnail']['extension'],
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),

              // Mostrar la descripción del personaje en el contenido de la página
              Text(
                'Descripción: ${character['description']}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),

              // Mostrar los nombres de las 3 primeras series del personaje en el contenido de la página
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Series:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    for (var i = 0;
                        i < 3 && i < character['series']['items'].length;
                        i++)
                      Text(
                        '${character['series']['items'][i]['name']}',
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),

              // Mostrar la cantidad de comics del personaje en el contenido de la página
              Text(
                'Cantidad de Comics: ${character['comics']['available']}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),

              // Mostrar la cantidad de series del personaje en el contenido de la página
              Text(
                'Cantidad de Series: ${character['series']['available']}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),

              // Mostrar la cantidad de stories del personaje en el contenido de la página
              Text(
                'Cantidad de Stories: ${character['stories']['available']}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),

              // Mostrar la cantidad de eventos del personaje en el contenido de la página
              Text(
                'Cantidad de Eventos: ${character['events']['available']}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
