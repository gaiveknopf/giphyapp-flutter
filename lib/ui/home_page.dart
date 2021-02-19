import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGiphys() async {
    http.Response response;

    if (_search == null)
      response = await http.get(
          'https://api.giphy.com/v1/gifs/trending?api_key=qiKzqN14GzDl2Nj1wEQ6c7IpM6ISgBeD&limit=10&rating=g');
    else
      response = await http.get(
          'https://api.giphy.com/v1/gifs/search?api_key=qiKzqN14GzDl2Nj1wEQ6c7IpM6ISgBeD&q=$_search&limit=10&offset=$_offset&rating=g&lang=en');

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _getGiphys().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#312e38'),
        title: Container(
          child: Image.network(
              'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
        ),
        centerTitle: true,
      ),
      backgroundColor: HexColor('#312e38'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Search the giphy",
                  labelStyle: TextStyle(color: HexColor('#ffffff')),
                  border: OutlineInputBorder()),
              style: TextStyle(color: HexColor('#ffffff'), fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _getGiphys(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            HexColor('#ffffff'),
                          ),
                          strokeWidth: 5,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createGiphyTable(context, snapshot);
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _createGiphyTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 20, top: 0, right: 20, left: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.network(
            snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
