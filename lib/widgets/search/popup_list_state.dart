import 'package:flutter/material.dart';
import 'package:covidindia/model/states_list.dart';

class PopupListStateWidget extends StatelessWidget {
  const PopupListStateWidget(this.item);

  final StatesList item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.stateName,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
