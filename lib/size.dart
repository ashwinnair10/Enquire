import 'package:flutter/widgets.dart';

double width(BuildContext context, double wp) {
  double width = MediaQuery.of(context).size.width;
  return width * wp;
}

double height(BuildContext context, double hp) {
  double height = MediaQuery.of(context).size.height;
  return height * hp;
}
