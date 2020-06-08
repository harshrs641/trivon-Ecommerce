// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: () =>add(), child: Icon(Icons.add)));
  }

  void add() async {
    List<DocumentSnapshot> q = await Firestore.instance
        .collection('products')
        .getDocuments()
        .then((value) => value.documents);
        print(q.length.toString());
    for (int i = 0; i < q.length; i++) {
      await Firestore.instance
          .collection('search')
          .document(q[i].documentID)
          .setData({
        'productID': q[i].documentID,
        'title': q[i]['title'],
        'key': q[i]['title'].substring(0, 1)
      });
    }
  }
}
