import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  final String startPage;
  final String endPage;

  const Breadcrumb({
    required this.startPage,
    required this.endPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(children: [
          Text(startPage),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Icon(Icons.arrow_right_alt_outlined),
          ),
          Text(endPage),
        ]));
  }
}
