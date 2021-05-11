
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SuffixIcon extends StatelessWidget {
  final IconData icon;

  const SuffixIcon({Key key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Icon(icon),
    );
  }
}
