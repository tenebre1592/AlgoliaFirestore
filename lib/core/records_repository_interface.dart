import 'package:AlgoliaFirestore/core/models/record.dart';

abstract class RecordsRepositoryInterface {
  // Future<List<Record>> fetch();
  Stream<List<Record>> get streamRecords;
  Future<void> save(List<Record> posts);
  Future<void> deleteAll();
}
