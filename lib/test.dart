import 'dart:convert';

import 'package:http/http.dart' as Http;

void main() {
  String url = 'https://api.covid19india.org/state_district_wise.json';
  getStateWisedata(url);
}

void getStateWisedata(String url) async {
  Http.Response response = await Http.get(url);
  List<String> statesList = [];
  List<String> districtsList = [];

  if (response.statusCode == 200) {
    String data = response.body;
    //dataJson = jsonDecode(dataResp);
    Map<String, dynamic> map = json.decode(data);
    //print(map.keys);
//    for (String state in map.keys) {
//      statesList.add(state);
//    }
    print(map);

    Map<String, dynamic> map2 = map['Andhra Pradesh']['districtData'];
    print('District List - ${map2.keys}');
    print('No of Districts - ${map2.length}');
    for (String district in map2.keys) {
      print(district);
      print(map2[district]['confirmed']);
      print(map2[district]['recovered']);
      print(map2[district]['deceased']);
    }

    //print(districtsList);
  }
}

class StatesList {
  final String stateName;

  StatesList(this.stateName);
}
