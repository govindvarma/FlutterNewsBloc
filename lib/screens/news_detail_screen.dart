import 'package:flutter/material.dart';
import 'package:newapi_bloc/models/new_api_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final Articles articles;
  NewsDetailScreen({@required this.articles});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Hero(
            tag: articles.urlToImage,
            child: Image.network(articles.urlToImage),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              articles.title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              articles.publishedAt,
            ),
          ),
          Text(articles.content),
        ],
      ),
    );
  }
}
