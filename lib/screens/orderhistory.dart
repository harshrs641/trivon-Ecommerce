import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatelessWidget {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        appBar: AppBarWidget().appbar(_key, context),
        drawer: UniDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('orders')
                .where('userID',isEqualTo:userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.documents.length != 0) {
                  return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              alignment: Alignment.center,
                              child: Text('Order History',
                                  style: GoogleFonts.spartan(
                                      fontSize: 35,
                                      color: Colors.blueGrey[400]))),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 10 * 8,
                          child: ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                return OrderItem(snapshot.data.documents[index]);
                              }),
                        )
                      ]);
                } else
                  return emptyHistory();
              } else
                return Container();
            }));
  }









  Widget emptyHistory() {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.history,
        size: 50,
        color: Colors.grey,
      ),
      Text(
        'No Order History',
        style: GoogleFonts.concertOne(color: Colors.grey),
      )
    ]));
  }
}

class OrderItem extends StatefulWidget {
  DocumentSnapshot singleOrder;
  OrderItem(this.singleOrder);
  @override
  _OrderItemState createState() => _OrderItemState(singleOrder);
}

class _OrderItemState extends State<OrderItem> {
DocumentSnapshot one;
  _OrderItemState(this.one);
  // String imageUrl = 'lib/images/circuit-breaker.jpg';
  // String title = 'Miniature Circuit Breaker';
  // String subtitle =
  //     'BH-010 miniature circuit breaker - Type C, single pole, 6A';
  // double price = 250.00;
  // String time = DateFormat.yMMMd().format(DateTime.now());
  // bool show = false;
//
  @override
  Widget build(BuildContext context) {
  
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2.5,
                child: Column(children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    color: Colors.orange[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Order ID: ${one.documentID}',
                                style: GoogleFonts.ubuntu(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Placed On: ${DateFormat.yMMMd().format(one.data['timestamp'].toDate())}',
                                style: GoogleFonts.ubuntu(),
                              ),
                            )
                          ]),
                    ),
                  ),
                  ...one.data['cart']['products'].map((key) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    ProductDetail(key['productID']))),
                        child: Card(
                          color: Colors.orange[50],
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  key['title'],
                                  style: GoogleFonts.montserrat(),
                                ),
                                Text(
                                  'X${key['count']}',
                                  style: GoogleFonts.montserrat(),
                                ),
                                Text(
                                  'Rs.${key['price']}/piece',
                                  style: GoogleFonts.montserrat(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Total: Rs.${one.data['cart']['total']}',
                          style: GoogleFonts.montserrat(),
                        )),
                  ),
                  Container(
                    color: Colors.blueGrey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status:', style: GoogleFonts.raleway()),
                          Text('${one.data['status']}',
                              style: GoogleFonts.raleway()),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          
  }
}

// Widget detail() {
//   return Container(
//     decoration: BoxDecoration(color: Colors.black12),
//     width: double.infinity,
//     child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Delivered to',
//                 style: GoogleFonts.josefinSans(
//                     fontSize: 16.5, fontWeight: FontWeight.bold)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Name: Harsh Raj Singh',
//                 style: GoogleFonts.josefinSans(fontSize: 16.5)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Address: 102/9, Beliaghata Main Road, Kolkata-700010',
//                 style: GoogleFonts.josefinSans(fontSize: 16.5)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Phone Number: 8420320655',
//                 style: GoogleFonts.josefinSans(fontSize: 16.5)),
//           )
//         ]),
//   );
// }
// }
