import 'package:AlgoliaFirestore/core/records_repository.dart';
import 'package:AlgoliaFirestore/services/remote_db/srvc_remote_db.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServicesManager {
  ServicesManager() {
    var firestore = getIt<SrvcRemoteDb>();
    var recordsRepo = getIt<RecordsRepository>();
    recordsRepo.init();
    firestore.init();
  }
}
