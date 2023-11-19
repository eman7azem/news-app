import 'package:flutter/material.dart';

import '../../models/SourcesResponse.dart';


class TabWidget extends StatefulWidget {
  bool isSelected;
  Sources source;
  TabWidget(this.source, this.isSelected, {super.key});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(18),
            color: widget.isSelected ? Colors.green : Colors.white),
        child: Text(
          widget.source.name ?? "",
          style:
              TextStyle(color: widget.isSelected ? Colors.white : Colors.green),
        ));
  }
}
