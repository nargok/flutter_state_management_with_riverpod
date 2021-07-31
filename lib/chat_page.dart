import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_post.dart';
import 'login_page.dart';

class ChatPage extends StatelessWidget {
  ChatPage(this.user);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャット'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Center(
        child: Text('ログイン情報: ${user.email}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddPost();
          }));
        },
      ),
    );
  }
}
