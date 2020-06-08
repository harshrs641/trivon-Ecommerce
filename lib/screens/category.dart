import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:ecommerce/widgets/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  String id;
  String name;
  CategoryScreen(this.id, this.name);
  @override
  _CategoryScreenState createState() => _CategoryScreenState(id, name);
}

class _CategoryScreenState extends State<CategoryScreen> {
  String id;
  String name;
  _CategoryScreenState(this.id, this.name);
  @override
  Widget build(BuildContext context) {
      GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

    return Scaffold(drawer: UniDrawer(),
        backgroundColor: Colors.white,key: _key,
        appBar: AppBarWidget().appbar(_key, context),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('products')
              .where('category', isEqualTo: id)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              if (snapshots.data != null)
                return ListView(children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Center(
                        child: Text(
                          name,
                          style: GoogleFonts.spartan(
                              color: Colors.blueGrey[400], fontSize: 27.5),
                        ),
                      )),
                  ...snapshots.data.documents.map((e) => ItemCard(e)).toList()
                ]);
              else
                return Container();
            } else
              return Container();
          },
        ));
  }
}
