import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychatapp/main.dart';

import 'add_post_page.dart';
import 'login_page.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final User user = watch(userProvider).state!;
    final AsyncValue<QuerySnapshot> asyncPostsQuery = watch(postsQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('チャット'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text('ログイン情報: ${user.email}'),
          ),
          Expanded(
              // whenを使うと、状態に応じた挙動を実装できる
              child: asyncPostsQuery.when(data: (QuerySnapshot query) {
            return ListView(
              children: query.docs.map((document) {
                return Card(
                  child: ListTile(
                    title: Text(document['text']),
                    subtitle: Text(document['email']),
                    trailing: document['email'] == user.email
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(document.id)
                                  .delete();
                            },
                          )
                        : null,
                  ),
                );
              }).toList(),
            );
          }, loading: () {
            return Center(
              child: Text('読込中...'),
            );
          }, error: (e, stackTrace) {
            return Center(
              child: Text(e.toString()),
            );
          }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddPostPage();
          }));
        },
      ),
    );
  }
}
