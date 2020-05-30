import 'package:AlgoliaFirestore/views/data_manager/screen_data_manager.dart';
import 'package:AlgoliaFirestore/views/records/screen_records.dart';
import 'package:AlgoliaFirestore/views/search/screen_search.dart';
import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:AlgoliaFirestore/constants/router_paths.dart';

class Router {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      defaultTransitions: [SailorTransition.fade_in],
      defaultTransitionCurve: Curves.linear,
      defaultTransitionDuration: Duration(milliseconds: 500),
    ),
  );

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(name: RouterPaths.records, builder: (_, __, ___) => ScreenRecords()),
      SailorRoute(name: RouterPaths.dataManager, builder: (_, __, ___) => ScreenDataManager()),
      SailorRoute(name: RouterPaths.search, builder: (_, __, ___) => ScreenSearch()),
    ]);
  }
}
