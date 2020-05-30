import 'dart:async';

import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:algolia/algolia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchVModel with ChangeNotifier {
  SearchVModel() {
    query = algolia.instance.index('records');
  }
  var txtCtrl = TextEditingController(text: "");
  List<Record> suggestions = [];
  bool isSearching = false;
  Timer _debounce;
  Algolia algolia = Algolia.init(
    applicationId: 'VM7CMOP4D2',
    apiKey: '8316fedff29f5bf523f41f191adf40eb',
  );
  AlgoliaQuery query;

  search() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isSearching = true;
      notifyListeners();
      query = query.search(txtCtrl.text);
      var results = (await query.getObjects()).hits;
      suggestions = results.map((e) {
        return Record.fromHighlightResult(e.highlightResult);
      }).toList();

      isSearching = false;
      notifyListeners();
    });
  }
}
