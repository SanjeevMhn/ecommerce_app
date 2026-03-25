import 'package:flutter/material.dart';

class CustomFloatingButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double x = scaffoldGeometry.scaffoldSize.width - 80;
    double y = scaffoldGeometry.scaffoldSize.height - 180;

    return Offset(x, y);
  }
}
