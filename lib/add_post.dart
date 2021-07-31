import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('チャット投稿'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('戻る'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ));
  }
}
