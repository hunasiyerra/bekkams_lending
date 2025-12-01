import 'package:bekkams_lending/corecomponents/mediaquery.dart';
import 'package:flutter/widgets.dart';

class Responsivelayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsivelayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final double width = Mediaquery.getScreenSize(context).width;
    //final Orientation orientation = Mediaquery.getOriention(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (width < 600) {
          return mobile;
        } else if (width > 600 && width < 1024) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
