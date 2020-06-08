// import 'dart:js';

import 'package:ecommerce/screens/category.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class McbSubCategory extends StatefulWidget {
  @override
  _McbSubCategoryState createState() => _McbSubCategoryState();
}

class _McbSubCategoryState extends State<McbSubCategory> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _key,
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appbar(_key, context),
      drawer: UniDrawer(),
      body: ListView(children: [
        Container(
            height: MediaQuery.of(context).size.height / 8,
            child: Center(
              child: Text(
                'Miniature Circuit Breaker',
                style: GoogleFonts.spartan(
                    color: Colors.blueGrey[400], fontSize: 25),
              ),
            )),
        Card(color: Colors.teal[100],
          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Channel Type',
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
            ),
            GestureDetector(onTap: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CategoryScreen('mcb2', 'Miniature Circuit Breaker'))),
                          child: Card(
                            child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [Icon(Icons.subdirectory_arrow_right),
                          Text('Miniature Circuit Breaker',style: GoogleFonts.raleway(),),
                        ],
                      ),Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(onTap: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CategoryScreen('isolator', 'Isolator'))),
                          child: Card(
                            child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [Icon(Icons.subdirectory_arrow_right),
                            Text('Isolator',style: GoogleFonts.raleway()),
                          ],
                        ),Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                ),
              ),
            )
          ]),
        ), Card(color: Colors.teal[100],
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
        'Mini MCB',
        style: GoogleFonts.montserrat(fontSize: 20),
                ),
              ),
              GestureDetector(onTap: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CategoryScreen('switch', 'Switch'))),
                              child: Card(
                    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: [Icon(Icons.subdirectory_arrow_right),
                  Text('Switch',style: GoogleFonts.raleway(),),
                ],
            ),Icon(Icons.arrow_forward_ios)
          ],
        ),
                  ),
                ),
              ),
              GestureDetector(onTap: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CategoryScreen('modular', 'Modular'))),
                              child: Card(
                    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(
                  children: [Icon(Icons.subdirectory_arrow_right),
                    Text('Modular',style: GoogleFonts.raleway()),
                  ],
                ),Icon(Icons.arrow_forward_ios)
            ],
          ),
                  ),
                ),
              )
            ]),
          )
      ]),
    );
  }
}
