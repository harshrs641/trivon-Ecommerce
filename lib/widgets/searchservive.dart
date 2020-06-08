import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  s() {
    return Firestore.instance.collection('search').getDocuments();
  }
}
