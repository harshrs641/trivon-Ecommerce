import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/screens/addaddresspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCheckOutPage extends StatefulWidget {
  @override
  _AddressCheckOutPageState createState() => _AddressCheckOutPageState();
}

class _AddressCheckOutPageState extends State<AddressCheckOutPage> {
  // List<Map<String, String>> addresses = [
  //   {
  //     'name': 'Swapnil Chatterjee',
  //     'address':
  //         '102/9 Beliaghata Main Road \n Near Jora Mandir\nKolkata -700010',
  //     'phone': '+918420320655',
  //     'value': "1"
  //   },
  //   {
  //     'name': 'Saahil Gupta',
  //     'address':
  //         '102/9 Beliaghata Main Road \n Near Jora Mandir\nKolkata -700010',
  //     'phone': '+918420320655',
  //     'value': '2'
  //   },
  //   {
  //     'name': 'Harsh Raj Singh',
  //     'address':
  //         '102/9 Beliaghata Main Road \n Near Jora Mandir\nKolkata -700010',
  //     'phone': '+918420320655',
  //     'value': '4'
  //   }
  // ];
  int current = 0;
  var allAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Address',
          style: GoogleFonts.quicksand(),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('addresses')
                  .document(userID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                   allAddress = snapshot.data.data['addresses'];
                  return Container(height:MediaQuery.of(context).size.height-200,
                    child: ListView.builder(
                        itemCount: allAddress.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                child: Container(
                                  color: Colors.teal[50],
                                  height: MediaQuery.of(context).size.height / 5,
                                  child: RadioListTile(
                                      title: addressTile(allAddress[index]),
                                      value: index,
                                      groupValue: current,
                                      onChanged: (value) => setState(() {
                                            print(value);
                                            current = value;
                                          })),
                                ),
                              ));
                        }),
                  );
                  // children: [
                  // ...addresses.map((e) => Padding(
                  //   padding: const EdgeInsets.all(3.0),
                  //   child: Card(
                  //         child: Container(
                  //           color: Colors.grey[300],
                  //           height: MediaQuery.of(context).size.height / 5,
                  //           child: RadioListTile(
                  //               title: addressTile(e),
                  //               value: int.parse(e['value']),
                  //               groupValue: current,
                  //               onChanged: (value) => setState(() {
                  //                     print(value);
                  //                     current = value;
                  //                   })),
                  //         ),
                  //       ),
                  // )),]);}

                } else
                  return Container();
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () => Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => AddAddressPage())),
                child: Text(
                  '+  Add Address',
                  style:
                      TextStyle(color: Colors.orangeAccent[100], fontSize: 20),
                )),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 100, left: 100),
              child: GestureDetector(
                onTap: () {order['address']=allAddress[current]; print(order);Navigator.of(context).pushNamed('/checkout');},
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
                          'PROCEED',
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

  Widget addressTile( element) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              element['name'],
              style: GoogleFonts.workSans(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(.5),
            child: Text(
              element['street'],
              style: GoogleFonts.titilliumWeb(color: Colors.grey[600]),
            ),
          ), Padding(
            padding: const EdgeInsets.all(.5),
            child: Text(
              element['landmark'],
              style: GoogleFonts.titilliumWeb(color: Colors.grey[600]),
            ),
          ), Padding(
            padding: const EdgeInsets.all(.5),
            child: Text(
              element['area'],
              style: GoogleFonts.titilliumWeb(color: Colors.grey[600]),
            ),
          ), Padding(
            padding: const EdgeInsets.all(.5),
            child: Text('Kolkata-'+
              element['pincode'],
              style: GoogleFonts.titilliumWeb(color: Colors.grey[600]),
            ),
          ),
          Text('Phone No.- '+
            element['phone'],
            style: GoogleFonts.titilliumWeb(color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
