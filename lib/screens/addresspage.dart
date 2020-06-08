import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/screens/editaddress.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      appBar: AppBarWidget().appbar(_key, context),
      drawer: UniDrawer(),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('addresses')
              .document(userID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var addresses = snapshot.data.data['addresses'];
              if (addresses.length != 0)
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 10 + 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Manage Address',
                              style: GoogleFonts.spartan(
                                  color:  Colors.blueGrey[400], fontSize: 35),
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/addAddress');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.orange[300],
                                    ),
                                    Text(' Add Address',
                                        style: GoogleFonts.monda(
                                            fontSize: 20,
                                            color: Colors.orange[300])),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 10 * 8 - 100,
                      child: ListView.builder(itemCount: addresses.length,itemBuilder:(context,index){return show(addresses[index],index);}),
                    ),
                  ],
                );
              else
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Text('Please add your Address',
                            style: GoogleFonts.quicksand(color: Colors.grey)),
                        SizedBox(height: 50),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/addAddress');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.orange[300],
                                ),
                                Text(' Add Address',
                                    style: GoogleFonts.monda(
                                        fontSize: 20,
                                        color: Colors.orange[300])),
                              ],
                            ))
                      ]),
                );
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  Widget show(single, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.orange[100],
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name:',
                      style: GoogleFonts.tajawal(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(
                    single['name'],
                    style: GoogleFonts.tajawal(fontSize: 15),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address:',
                    style: GoogleFonts.tajawal(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(single['street'],
                          style: GoogleFonts.tajawal(fontSize: 15)),
                      Text(single['landmark'],
                          style: GoogleFonts.tajawal(fontSize: 15)),
                      Text(single['area'],
                          style: GoogleFonts.tajawal(fontSize: 15)),
                      Row(
                        children: [
                          Text('Kolkata-',
                              style: GoogleFonts.tajawal(fontSize: 15)),
                          Text(single['pincode'],
                              style: GoogleFonts.tajawal(fontSize: 15)),
                        ],
                      )
                    ])
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone Number:',
                    style: GoogleFonts.tajawal(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(single['phone'], style: GoogleFonts.tajawal(fontSize: 15))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alternate Number:',
                    style: GoogleFonts.tajawal(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                    (single['alter'] != null)
                        ? single['alter']
                        : 'Not Provided',
                    style: GoogleFonts.tajawal(fontSize: 15))
              ],
            ),
          ),
          GestureDetector(onTap: (){Navigator.of(context).push( CupertinoPageRoute(builder: (context)=>EditAddressPage(single,index)));},
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Edit Address',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                      ),
                    ),
                  ))))
        ]),
      ),
    );
  }
}
