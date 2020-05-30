import 'package:AlgoliaFirestore/constants/router_paths.dart';
import 'package:AlgoliaFirestore/services/router.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(this._index);
  final String _index;

  @override
  Widget build(BuildContext context) {
    final _inactiveColor = Theme.of(context).disabledColor;
    final _disabledColor = Theme.of(context).primaryColor;
    final double _iconSize = 26;
    var _list = <Widget>[];

    //----------------------------------------records
    var records = IconButton(
      icon: Icon(Icons.assignment),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.records
          ? null
          : () => Router.sailor
              .navigate(RouterPaths.records, navigationType: NavigationType.pushReplace),
    );

    //----------------------------------------dataManager
    var dataManager = IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.dataManager
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.dataManager, navigationType: NavigationType.pushReplace);
            },
    );

    //----------------------------------------search
    var search = IconButton(
      icon: Icon(Icons.search),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.search
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.search, navigationType: NavigationType.pushReplace);
            },
    );

    _list = [records, dataManager, search];
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _list,
      ),
    );
  }
}
