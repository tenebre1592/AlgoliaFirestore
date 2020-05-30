import 'dart:async';

import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:AlgoliaFirestore/core/records_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class RecordsVModel with ChangeNotifier {
  RecordsVModel() {
    cache = _repo.cache;
    _subsc = _repo.updates.listen((_) {
      cache = _repo.cache;
      notifyListeners();
    });
  }
  StreamSubscription _subsc;
  var cache = <Record>[];
  final _repo = getIt<RecordsRepository>();
  @override
  void dispose() {
    _subsc.cancel();
    super.dispose();
  }
}
