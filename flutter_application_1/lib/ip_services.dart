import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'characters.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> data = [];
  String searchText = '';

  Future fetchData() async {
    const ts = '1005';
    const apiKey = '5e61290a4e5ec51d589fbec49ae55f96';
    const hash = '45d53f411ed927922f090e25fe30a5b9';

    String url;
    if (searchText.isEmpty) {
      url =
          'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$apiKey&hash=$hash&limit=20&offset=1';
    } else {
      url =
          'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$apiKey&hash=$hash&nameStartsWith=$searchText';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        data = jsonData['data']['results'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _onCharacterTap(dynamic character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailsPage(character: character),
      ),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel personajes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar personaje...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    fetchData();
                  },
                ),
              ),
              onChanged: (value) {
                searchText = value;
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        _onCharacterTap(data[index]);
                      },
                      child: Image.network(
                        data[index]['thumbnail']['path'] +
                            '.' +
                            data[index]['thumbnail']['extension'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
