import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  // String title1 = 'Miniature Circuit Breaker';
  // String quant1 = '5';
  // String totalprice1 = '1000';
  // String title2 = 'Soldering Machine';
  // String quant2 = '3';
  // String totalprice2 = '9000';
  // String total = '10000';
  // String name = 'Harsh Raj Singh';
  // String address =
  //     '102/9, Beliaghata Main Road \nNear Jora Mandir\nKolkata -700010\nWest Bengal';
  // String phone = '+918420320655';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: Text(
          'CHECKOUT',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: ListView(children: [
        SizedBox(height: 20),
        ...order['cart']['products'].map((key)=>Container(
          decoration: BoxDecoration(color: Colors.orange[50]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key['title'],
                  style: GoogleFonts.barlow(fontSize: 20),
                ),
                Text('X${key['count']}', style: GoogleFonts.barlow()),
                Text('Rs.${key['totalprice']}', style: GoogleFonts.barlow())
              ],
            ),
          ),
        )),
        SizedBox(height: 10),
        // Container(
        //   decoration: BoxDecoration(color: Colors.orange[50]),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(title2, style: GoogleFonts.barlow(fontSize: 20)),
        //         Text('X$quant2', style: GoogleFonts.barlow()),
        //         Text('Rs.$totalprice2', style: GoogleFonts.barlow())
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Delivering to: ',
                    style: GoogleFonts.barlow(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(order['address']['name'], style: GoogleFonts.barlow()),
                      Text(order['address']['street'],
                          style: GoogleFonts.barlow()),
                      Text(order['address']['area'],
                          style: GoogleFonts.barlow()),
                      Text(order['address']['landmark'],
                          style: GoogleFonts.barlow()),
                      Text('Kolkata-${order['address']['pincode']}',
                          style: GoogleFonts.barlow()),
                      Text('West Bengal', style: GoogleFonts.barlow()),
                      Text('Phone Number:${order['address']['phone']}',
                          style: GoogleFonts.barlow())
                    ],
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Payment Mode:', style: GoogleFonts.barlow()),
            Text('Cash On Delivery(COD)', style: GoogleFonts.barlow())
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total Amount:', style: GoogleFonts.barlow()),
            Text('Rs.${order['cart']['total']}', style: GoogleFonts.barlow())
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Text('Will be delivered in 4-5 Days',
                  style: TextStyle(color: Colors.grey))),
        ),
        SizedBox(height: 40),
        Padding(
            padding: const EdgeInsets.only(right: 100, left: 100),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/thankyou');
                // order['timestamp']=DateTime.now();
                // order['status']='Yet to be Delivered';
                Firestore.instance.collection('orders').add({'userID':userID,
                  // 'order': order,
                  'timestamp': DateTime.now(),
                  'status': 'Yet to be Delivered',
                  'cart': order['cart'],
                  'address': order['address']
                });
                Firestore.instance
                    .collection('carts')
                    .document(userID)
                    .setData({'products': [], 'subtotal': 0, 'total': 49});
              },
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
                        'CONFIRM',
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
      ]),
    );
  }
}
