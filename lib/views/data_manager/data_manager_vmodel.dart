// import 'package:AlgoliaFirestore/core/posts_repository.dart';
import 'dart:io';

import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:AlgoliaFirestore/core/records_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DataManagerVModel with ChangeNotifier {
  final _repo = getIt<RecordsRepository>();
  var _records = <Record>[];

  String get text =>
      _records.map<String>((record) => record.title + ' ' + record.body).toList().join('\n\n\n');

  //-----------------------------------------
  Future<void> handleChooseBtn(GlobalKey<ScaffoldState> key) async {
    _records.clear();
    File file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['txt']);
    String contents = await file.readAsString();
    var words = contents.split(' ');
    for (int i = 0; i < 20; i++) {
      _records.add(Record(title: words.first, body: words.skip(1).take(11).join(' ')));
      if (words.length >= 11) {
        words.removeRange(0, 11);
      }
    }
    notifyListeners();
    uploadRecords(key);
  }

  //-----------------------------------------
  void uploadRecords(GlobalKey<ScaffoldState> key) {
    if (_records.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('No data to upload, choose a file please.'),
        duration: Duration(seconds: 2),
      ));
    } else {
      _repo.save(_records);
    }
  }

  //-----------------------------------------
  void deleteAll() => _repo.deleteAll();
}
