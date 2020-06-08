// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:ecommerce/widgets/itemCard.dart';
import 'package:ecommerce/widgets/searchservive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
    // TODO: implement buildLeading
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return ListView(children: [...perresults.map((e) => ItemCard(e))]);
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  var perresults;
  // @override
  Widget buildSuggestions(BuildContext context) {
    // var results;
    if (query.isEmpty)
      return Center(
          child: Text(
        'Please Enter Product Name',
        style: GoogleFonts.quicksand(color: Colors.grey),
      ));
    else
      return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('search').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final results = snapshot.data.documents.where((element) => element
                  .data['title']
                  .toUpperCase()
                  .contains(query.toUpperCase()));
              perresults = results;
              return ListView(children: [
                Container(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      child: Text(
                        'show All',
                        style: TextStyle(color: Colors.blueAccent[300]),
                      ),
                      onPressed: () => showResults(context),
                    )),
                ...results
                    .map((e) => Card(
                          elevation: 0,
                          child: ListTile(
                            enabled: true,
                            onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ProductDetail(e.documentID))),
                            selected: true,
                            title: Text(e.data['title'],
                                style: GoogleFonts.ubuntu(
                                    fontSize: 15, color: Colors.grey)),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                          ),
                        ))
                    .toList()
              ]);
            } else
              return CircularProgressIndicator();
          });

    // TODO: implement buildSuggestions
    // throw UnimplementedError();
  }
}
// class SearchByName{
//   // List<String> query=['Hrsh','Aanchal','Tanya','Swapnil','Saahil'];
//   List<Map<String,String>> query;
//   void search(String value)
// {
//   if(value.length==0) {query=[];}
//   }
// }
