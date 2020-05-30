import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class SrvcRemoteDb {
  var _firestore = Firestore.instance.collection('records');

  var _streamCtrlRecords = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get streamRecords => _streamCtrlRecords.stream;

  Future<void> save(List<Map<String, dynamic>> list) {
    for (var record in list) _firestore.document().setData(record);
    return null;
  }

  Future<void> deleteAll() async {
    var result = await _firestore.getDocuments();
    for (var doc in result.documents) doc.reference.delete();
    return null;
  }

  void fetch(QuerySnapshot snapshot) {
    if (snapshot != null) {
      var result = snapshot.documents
          .map((document) => {'title': document['title'], 'body': document['body']})
          .toList();
      _streamCtrlRecords.sink.add(result);
    }
  }

  void init() {
    _firestore.snapshots().listen(fetch);
  }

  dispose() {
    _streamCtrlRecords.close();
  }
}
