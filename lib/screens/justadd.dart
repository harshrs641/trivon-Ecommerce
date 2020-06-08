import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JustAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      'price': 820,
      'imageurl': 'v',
      'stock': 'instock',
      'category': 'ceilingfan',
      'title': 'Classic Ceiling Fan 48inch',
      'subtitle': ' ',
      // 'techSpecs': {
      //   'Model': 'MCB Box (Single Door)',
      //   'Type': '12 Way',
      //   'Board Material': 'Iron',
      //   'Color': 'White',
      //   'Rust Resistance': 'Yes'
      // },
      'features': [
        '100% Copper Winding',
        'Super Efficient 14 pole motor for more air thrust',
        'Better performance even at low voltage',
        'Wide spread air circulator',
        'Two Year Guarantee for Motor'
      ]
    };
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Firestore.instance
                .collection('products')
                .getDocuments()
                .then((value) async{
                  for(int i=0;i<value.documents.length;i++)
                  {
                    await value.documents[i].reference.setData({'rating':0,'noofrating':0},merge:true);
                  }
                })));
  }
}
// 'Rated insulation voltage': '440V',
// 'Based on standard': 'IEC 60898-1',        // 'Type of overcurrent release': 'Thermal, Magnetic',
// 'Terminal Connection': 'Solderless',        // 'Short circuit capactiy': '10kA',
// 'Ambient Temperature': '-25C to +70C',

// 'Applicable wire size': '1 to 25 sq.mm'
// 'State of the art design',
//  'High short circuit withstanding capacity',
//         'Can be locked in the on or off position',
//         'Easy to mount and remove',
//         'Interchangable terminal connection',
//         'Bi-connect terminals for ultimate flexibility'
// 'Rate Current': '32A',
//         'No.of Poles': '2',
//         'Tripping Characteristics': 'C-Curve',
//         'Short Circuit Capacity': '3kA',
//         'Rated Voltage': '240V AC',
//         'Rated Frequency': '50Hz',
//         'Mounting': 'Snapfit',
//         'Protection': 'IP2O',
//         'Suitable for Protection': 'Per Point Protection'
//  'Unique gear box system for smoother oscillation',
//         'Powerfull and Energy efficient ',
//         'Unique single piece plastic blade',
//         'Powder coated guards and fancy show caps',
//         'Available with double pull',
//         'Noise less',
//         'Strong 28mm stack motor',
//         'Two Year Guarantee for Motor'
