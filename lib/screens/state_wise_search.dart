import 'dart:convert';
import 'dart:io';

import 'package:covidindia/model/states_list.dart';
import 'package:covidindia/widgets/search/selected_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';
import 'package:http/http.dart' as Http;
import 'package:covidindia/widgets/search/popup_list_state.dart';
import 'package:covidindia/widgets/search/no_item_found.dart';
import 'package:covidindia/widgets/search/search_text_field.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

String url = 'https://api.covid19india.org/state_district_wise.json';

class StateWiseSearchHomePage extends StatefulWidget {
  @override
  _StateWiseSearchHomePageState createState() =>
      _StateWiseSearchHomePageState();
}

class _StateWiseSearchHomePageState extends State<StateWiseSearchHomePage> {
  StatesList _selectedItem;

  bool _show = true;

  List<StatesList> statesList = [];
  Map<String, dynamic> mapStates;

  int districtCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListOfStates(url);
  }

  void getListOfStates(String url) async {
    Http.Response response = await Http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      mapStates = json.decode(data);
      for (String state in mapStates.keys) {
        statesList.add(StatesList(state));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State-wise Search'),
        leading: Container(
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            if (_show)
              SearchWidget<StatesList>(
                dataList: statesList,
                hideSearchBoxWhenItemSelected: false,
                listContainerHeight: MediaQuery.of(context).size.height / 4,
                queryBuilder: (query, list) {
                  return list
                      .where((item) => item.stateName
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                  return PopupListStateWidget(item);
                },
                selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                  return SelectedItemWidget(
                      selectedItem, deleteSelectedItem, mapStates);
                },
                // widget customization
                noItemsFoundWidget: NoItemsFound(),
                textFieldBuilder: (controller, focusNode) {
                  return SearchTextField(controller, focusNode);
                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                    //getDistrictsData(CovidHome.map, _selectedItem.stateName);
                  });
                },
              ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "${_selectedItem != null ? _selectedItem.stateName : ""
                  "No item selected"}",
            ),
          ],
        ),
      ),
    );
  }
}
