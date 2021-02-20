import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share/share.dart';

class GiphyPage extends StatelessWidget {
  final Map _giphyData;

  GiphyPage(this._giphyData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#312e38'),
        title: Container(
          child: Text(_giphyData["title"]),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(_giphyData["images"]["fixed_height"]["url"]);
            },
          )
        ],
      ),
      backgroundColor: HexColor('#312e38'),
      body: Center(
        child: Image.network(_giphyData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
