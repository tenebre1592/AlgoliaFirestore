import 'package:AlgoliaFirestore/constants/router_paths.dart';
import 'package:AlgoliaFirestore/views/common/bottom_navigation.dart';
import 'package:AlgoliaFirestore/views/data_manager/data_manager_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class ScreenDataManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider<DataManagerVModel>(
      create: (context) => DataManagerVModel(),
      builder: (context, _) {
        var vModel = Provider.of<DataManagerVModel>(context, listen: false);
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: Text('Data Upload')),
          bottomNavigationBar: BottomNavigation(RouterPaths.dataManager),
          backgroundColor: Colors.grey[400],
          body: Scrollbar(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => vModel.handleChooseBtn(_scaffoldKey),
                      child: Text('Upload text'),
                    ),
                    RaisedButton(
                      onPressed: () => vModel.deleteAll(),
                      child: Text('Delete records'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          Text(context.select<DataManagerVModel, String>((vModel) => vModel.text)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
