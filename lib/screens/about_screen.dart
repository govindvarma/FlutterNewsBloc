import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Developer: Govind Varma'),
      ),
    );
  }
}
