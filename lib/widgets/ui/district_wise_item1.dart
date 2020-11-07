import 'package:covidindia/widgets/home/app_data.dart';
import 'package:covidindia/widgets/home/district_statewise_list.dart';
import 'package:flutter/material.dart';

class DistrictWiseItem extends StatelessWidget {
  const DistrictWiseItem({this.stateName, this.mapping});

  final String stateName;
  final Map mapping;

  List<DistrictData> getDistrictsData(
      Map<String, dynamic> statesData, String stateSelected) {
    Map<String, dynamic> map2 = statesData[stateSelected]['districtData'];

    List<DistrictData> districtList = [];

    for (String district in map2.keys) {
      districtList.add(
        DistrictData(
          districts: district,
          infected: map2[district]['confirmed'].toString(),
          recovered: map2[district]['recovered'].toString(),
          deceased: map2[district]['deceased'].toString(),
        ),
      );
    }

    return districtList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppData(
                dataLabel: 'District',
                fontWeight: FontWeight.w700,
                //colour: Colors.black,
              ),
              AppData(
                dataLabel: 'Confirmed',
                fontWeight: FontWeight.w700,
                colour: Colors.redAccent,
              ),
              AppData(
                dataLabel: 'Recovered',
                fontWeight: FontWeight.w700,
                colour: Colors.green,
              ),
              AppData(
                dataLabel: 'Deaths',
                fontWeight: FontWeight.w700,
                colour: Colors.blueAccent,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            children: getDistrictsData(mapping, stateName),
          ),
        ],
      ),
    );
  }
}
