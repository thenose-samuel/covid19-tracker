import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class Fetcher {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('meghalaya');
  Map<dynamic, dynamic> meghalaya = {};
  Map<String, int> data = {};

  Future<dynamic> readData() {
    var snap;
    databaseReference.once().then((DataSnapshot snapshot) {
      meghalaya = snapshot.value;
      meghalaya.forEach((key, value) {
        data[key] = value;
      });
      snap = snapshot;
    });
  return snap;
  }
}
