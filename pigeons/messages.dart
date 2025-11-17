import 'package:pigeon/pigeon.dart';

enum Status { paused, readyToPrint, unknown }

enum Cause {
  partialFormatInProgress,
  headCold,
  headOpen,
  headTooHot,
  paperOut,
  ribbonOut,
  receiveBufferFull,
  noConnection,
  unknown,
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/src/main/kotlin/org/didata/zsdk/Messages.g.kt',
    kotlinOptions: KotlinOptions(),
    // swiftOut: 'ios/zebra_printing/Sources/zebra_printing/Messages.g.swift',
    // swiftOptions: SwiftOptions(),
    objcHeaderOut: 'ios/Classes/Messages.g.h',
    objcSourceOut: 'ios/Classes/Messages.g.m',
    dartPackageName: 'zsdk',
  ),
)
class StatusInfo {
  final Status status;
  final Cause cause;

  const StatusInfo({required this.status, required this.cause});
}

@HostApi()
abstract class ZebraPrinting {
  StatusInfo checkPrinterStatusOverTCPIP();
}
