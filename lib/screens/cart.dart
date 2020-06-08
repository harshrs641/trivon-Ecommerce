import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String imageUrl = 'lib/images/circuit-breaker.jpg';
  // String title = 'Miniature Circuit Breaker';
  // String subtitle =
  //     'BH-010 miniature circuit breaker - Type C, single pole, 6A';
  // double price = 250.00;
  // List<Map<String, String>> cartData = [
  //   {
  //     'imageUrl': 'lib/images/saahil.jpeg',
  //     'title': 'Miniature Circuit Breaker',
  //     'subtitle': 'BH-010 miniature circuit breaker - Type C, single pole, 6A',
  //     'price': '250.00'
  //   },
  //   {
  //     'imageUrl': 'lib/images/saahil.jpeg',
  //     'title': 'Miniature Circuit Breaker',
  //     'subtitle': 'BH-010 miniature circuit breaker - Type C, single pole, 6A',
  //     'price': '250.00'
  //   },
  //   {
  //     'imageUrl': 'lib/images/saahil.jpeg',
  //     'title': 'Miniature Circuit Breaker',
  //     'subtitle': 'BH-010 miniature circuit breaker - Type C, single pole, 6A',
  //     'price': '250.00'
  //   },
  //   {
  //     'imageUrl': 'lib/images/saahil.jpeg',
  //     'title': 'Miniature Circuit Breaker',
  //     'subtitle': 'BH-010 miniature circuit breaker - Type C, single pole, 6A',
  //     'price': '250.00'
  //   }
  // ];
  // String imageUrl= 'lib/images/saahil.jpeg';
  Map<String, dynamic> cart;
  // List cartProducts;
  GlobalKey<ScaffoldState>_key= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key:_key,drawer: UniDrawer(),
    appBar: AppBarWidget().appbar(_key, context),
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('carts')
                .document(userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                cart = snapshot.data.data;
                if(cart['subtotal']!=0)
                // cartProducts = snapshot.data.data['products'];
                return Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 10,
                      child: Center(
                          child: Column(
                        children: [
                          // SizedBox(height: 75),
                          Text('Your Bag',
                         style: GoogleFonts.spartan(color:Colors.blueGrey[400],
                              fontSize: 35
                            )),
                          Text(
                            cart['products'].length.toString() + ' ITEMS',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ))),
                  Container(
                      height: MediaQuery.of(context).size.height / 5 * 3,
                      child: ListView.builder(
                        itemCount: cart['products'].length,
                        itemBuilder: (context, index) {
                          return itemCard(cart['products'][index], index);
                        },
                        //   : [
                        //   ...cartProducts
                        //       .map((e) => itemCard(e))
                        //       .toList()
                        // ]
                      )),
                  checkOutArea(cart),
                ]);else return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.shopping_cart,size: 50,color: Colors.grey,),
                      Text('Your Cart is Empty',style:GoogleFonts.quicksand(color: Colors.grey)),
                    ],
                  ),
                );
              } else
                return Container();
            }));
  }

  Widget checkOutArea(cartTotal) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SubTotal:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Rs.' + cartTotal['subtotal'].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      '+Rs.49 Delivery Charges',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('TOTAL',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Rs.' + cartTotal['total'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25)),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(right: 100, left: 100),
              child: GestureDetector(
                onTap: () { order['cart']=cart;Navigator.of(context).pushNamed('/addresscheckout');},
                child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black45,
                          size: 15,
                        ),
                        Text(
                          'CHECKOUT',
                          style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5),
                        ),
                      ],
                    ),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ))
        ],
      ),
    );
  }

  Widget itemCard(e, int index) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('products')
            .document(e['productID'])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(12),bottomRight:Radius.circular(12))),
                elevation: 1,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                          height: 135,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imageUrl),
                                  fit: BoxFit.fill))),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 215,
                                  // height: 50,
                                  child: Text(
                                    snapshot.data.data['title'],
                                    style: GoogleFonts.ubuntu(fontSize: 15),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 215,
                                  // height: 50,
                                  child: Text(
                                    snapshot.data.data['subtitle'],
                                    style: GoogleFonts.quicksand(
                                        color: Colors.grey, fontSize: 12.5),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rs.' + snapshot.data.data['price'].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ]),
                      Container(
                        child: singleProductCount(index),
                      ),
                    ]),
                    GestureDetector(
                        child: Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(12),bottomRight:Radius.circular(12)),color:Colors.red[200]),
                          child: Center(child: Text('Remove',style: GoogleFonts.nunito(fontSize: 17.5,color: Colors.black38)
                        ))),
                        onTap: () => dialog(context, index))
                  ],
                ));
          } else
            return Container();
        });
  }

  Widget singleProductCount(int index) {
    //  Map<String,dynamic> thatProduct;
    // Firestore.instance.collection('carts').document(userID).get().then((value) =>thatProduct= value.data['products'].singleWhere((element) => element['productID']==productID));
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              cart['products'][index]['count']++;
              cart['products'][index]['totalprice'] = cart['products'][index]
                      ['count'] *
                  cart['products'][index]['price'];
              cart['subtotal'] =
                  cart['subtotal'] + cart['products'][index]['price'];
              cart['total'] = cart['subtotal'] + 49;

              // cartProducts=cartProducts.map((e) {if( e.containsValue(productID))e['count']=e['count']+1;}).toList();
              Firestore.instance
                  .collection('carts')
                  .document(userID)
                  .setData(cart, merge: true);
            },
          ),
          Container(
              width: 25,
              child: Center(child: Text(cart['products'][index]['count'].toString()))),
          IconButton(
            icon: Icon(Icons.indeterminate_check_box),
            onPressed: () {
              if (cart['products'][index]['count'] > 1) {
                cart['products'][index]['count']--;
                cart['products'][index]['totalprice'] = cart['products'][index]
                        ['count'] *
                    cart['products'][index]['price'];
                cart['subtotal'] =
                    cart['subtotal'] - cart['products'][index]['price'];
                cart['total'] = cart['subtotal'] + 49;
                Firestore.instance
                    .collection('carts')
                    .document(userID)
                    .setData(cart, merge: true);
              }
            },
          ),
        ]);
  }

  void dialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
                backgroundColor: Colors.red[200],
                title: Text('Remove from Cart?',style: GoogleFonts.nunito(color: Colors.white),),
                actions: [
                  RaisedButton(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No')),
                  RaisedButton(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)) ,
                      onPressed: () {
                        cart['subtotal'] = cart['subtotal'] -
                            cart['products'][index]['totalprice'];
                        cart['total'] = cart['subtotal'] + 49;

                        cart['products'].removeAt(index);
                        Firestore.instance
                            .collection('carts')
                            .document(userID)
                            .setData(cart, merge: true);
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'))
                ]));
  }
}
