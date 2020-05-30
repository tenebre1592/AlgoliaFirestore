import 'dart:async';
import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:AlgoliaFirestore/core/records_repository_interface.dart';

class RecordsRepository {
  RecordsRepository({this.remoteDb});

  final RecordsRepositoryInterface remoteDb;

  var _cache = <Record>[];

  StreamSubscription _subsc;

  var _streamUpdates = StreamController<bool>.broadcast();
  Stream<bool> get updates => _streamUpdates.stream;

  //-----------------------------------------
  void init() {
    _subsc = remoteDb.streamRecords.listen((list) {
      _cache = list;
      _streamUpdates.sink.add(true);
    });
  }

  //-----------------------------------------
  Future<void> save(List<Record> list) {
    return remoteDb.save(list);
  }

  //-----------------------------------------
  List<Record> get cache => _cache;

  //-----------------------------------------
  Future<void> deleteAll() => remoteDb.deleteAll();

  //-----------------------------------------
  void dispose() {
    _subsc.cancel();
    _streamUpdates.close();
  }
}
