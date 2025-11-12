import 'enumerators/orientation.dart';

/// Created by luis901101 on 2020-01-07.
final class PrinterConf {
  final double? cmWidth;
  final double? cmHeight;
  final double? dpi;
  final Orientation? orientation;

  const PrinterConf({this.cmWidth, this.cmHeight, this.dpi, this.orientation});
}
