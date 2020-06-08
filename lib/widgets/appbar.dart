import 'package:ecommerce/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarWidget {
  Widget appbar(GlobalKey<ScaffoldState>key, BuildContext context) {
    return  AppBar(automaticallyImplyLeading:false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(color:Colors.orangeAccent[200],
              icon: Icon(
                Icons.menu,
              ),
              iconSize: 30,
              onPressed: () =>key.currentState.openDrawer()
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TRIV',
                    style: GoogleFonts.ubuntu(letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                        color: Colors.teal[300]),
                  ),
                  Image.asset(
                    'lib/images/invertedeco.png',
                    alignment: Alignment.topCenter,
                    height: 27,
                  ),
                  Text('N',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                        color: Colors.teal[700],
                      )),IconButton(icon: Icon(Icons.search,size: 30,color: Colors.orange[700],),onPressed: ()=>showSearch(context: context, delegate: SearchWidget()),),
                ],
              ),
            ),
            IconButton(color: Colors.orangeAccent[200],
              iconSize: 30,
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {Navigator.of(context).pushNamed('/cart');},
            )
          ],
        ),
        backgroundColor: Colors.white,elevation: 0.0,
      )
    ;
  }
}
