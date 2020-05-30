import 'package:AlgoliaFirestore/constants/router_paths.dart';
import 'package:AlgoliaFirestore/core/models/record.dart';
import 'package:AlgoliaFirestore/views/common/bottom_navigation.dart';
import 'package:AlgoliaFirestore/views/records/records_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        bottomNavigationBar: BottomNavigation(RouterPaths.records),
        body: ChangeNotifierProvider(
            create: (_) => RecordsVModel(),
            builder: (context, _) {
              var vModel = Provider.of<RecordsVModel>(context, listen: false);
              return NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                  SliverAppBar(
                    expandedHeight: 140.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("RECORDS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 8,
                                ),
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 4,
                                ),
                              ],
                            )),
                        background: FittedBox(
                            fit: BoxFit.cover, child: Image.asset('assets/background.jpg'))),
                  ),
                ],
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: Selector<RecordsVModel, List<Record>>(
                      selector: (_, vModel) => vModel.cache,
                      builder: (context, records, child) {
                        if (records.isEmpty) return Center(child: Text('НЕТ ЗАПИСЕЙ'));
                        return ListView.builder(
                          itemCount: vModel.cache.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              // dense: true,
                              title: Text(
                                vModel.cache[index].title,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                              subtitle: Text(
                                vModel.cache[index].body,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
