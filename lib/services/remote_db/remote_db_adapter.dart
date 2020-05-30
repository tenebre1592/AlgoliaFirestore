import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:AlgoliaFirestore/core/records_repository_interface.dart';
import 'package:AlgoliaFirestore/services/remote_db/srvc_remote_db.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class RemoteDbAdapter implements RecordsRepositoryInterface {
  final _serviceRemoteDb = getIt<SrvcRemoteDb>();

  Stream<List<Record>> get streamRecords {
    return _serviceRemoteDb.streamRecords.map<List<Record>>((list) {
      return list.map((item) => Record.fromMap(item)).toList();
    });
  }

  @override
  Future<void> deleteAll() => _serviceRemoteDb.deleteAll();

  @override
  Future<void> save(List<Record> records) {
    return _serviceRemoteDb.save(records.map((record) => record.toMap).toList());
  }
}
