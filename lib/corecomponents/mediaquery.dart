import 'package:flutter/widgets.dart';

class Mediaquery {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Orientation getOriention(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
