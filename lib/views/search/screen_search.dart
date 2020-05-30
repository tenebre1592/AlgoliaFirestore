import 'package:AlgoliaFirestore/constants/router_paths.dart';
import 'package:AlgoliaFirestore/views/common/bottom_navigation.dart';
import 'package:AlgoliaFirestore/views/search/search_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class ScreenSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider<SearchVModel>(
      create: (context) => SearchVModel(),
      builder: (context, _) {
        var vModel = Provider.of<SearchVModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(title: Text('Search')),
          bottomNavigationBar: BottomNavigation(RouterPaths.search),
          backgroundColor: Colors.grey[400],
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: vModel.txtCtrl,
                  decoration: InputDecoration(labelText: "Search query here..."),
                  onChanged: (_) => vModel.search(),
                ),
                Selector<SearchVModel, bool>(
                  selector: (_, vModel) => vModel.isSearching,
                  builder: (context, isSearching, child) {
                    return Expanded(
                      child: isSearching == true
                          ? Center(child: Text("Searching, please wait..."))
                          : vModel.suggestions.length == 0
                              ? Center(child: Text("No results found"))
                              : ListView.builder(
                                  itemCount: vModel.suggestions.length,
                                  itemBuilder: (_, int index) => Card(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundColor: Colors.blue,
                                                    radius: 10.0,
                                                    child: Text((index + 1).toString()),
                                                  ),
                                                  Expanded(
                                                      child: Html(
                                                    data: vModel.suggestions[index].title,
                                                    customRender: {
                                                      'em': (_, __, ___, element) => Text(
                                                            element.text,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.blue,
                                                              backgroundColor: Colors.grey[100],
                                                            ),
                                                          )
                                                    },
                                                  ))
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Html(
                                                    data: vModel.suggestions[index].body,
                                                    customRender: {
                                                      'em': (_, __, ___, element) => Text(
                                                            element.text,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.blue,
                                                              backgroundColor: Colors.grey[100],
                                                            ),
                                                          )
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
