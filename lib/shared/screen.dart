import 'package:flutter/material.dart';

enum Device {
  phone(),
  tablet(),
  pc();

  static const double kTabletBreakpoint = 600;
  static const double kPcBreakpoint = 1200;
}

class Screen {
  BuildContext context;

  Screen(this.context);

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  Device get device {
    if (width > Device.kPcBreakpoint) {
      return Device.pc;
    }
    if (width > Device.kTabletBreakpoint) {
      return Device.pc;
    }
    return Device.phone;
  }
}
