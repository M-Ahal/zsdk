import 'enumerators/head_close_action.dart';
import 'enumerators/media_type.dart';
import 'enumerators/power_up_action.dart';
import 'enumerators/print_method.dart';
import 'enumerators/print_mode.dart';
import 'enumerators/reprint_mode.dart';
import 'enumerators/virtual_device.dart';
import 'enumerators/zpl_mode.dart';

/// Created by luis901101 on 2020-02-10.
class PrinterSettings {
  /// Fields name
  static const _kFieldDarkness = 'darkness';
  static const _kFieldPrintSpeed = 'printSpeed';
  static const _kFieldTearOff = 'tearOff';
  static const _kFieldMediaType = 'mediaType';
  static const _kFieldPrintMethod = 'printMethod';
  static const _kFieldPrintWidth = 'printWidth';
  static const _kFieldLabelLength = 'labelLength';
  static const _kFieldLabelLengthMax = 'labelLengthMax';
  static const _kFieldZplMode = 'zplMode';
  static const _kFieldPowerUpAction = 'powerUpAction';
  static const _kFieldHeadCloseAction = 'headCloseAction';
  static const _kFieldLabelTop = 'labelTop';
  static const _kFieldLeftPosition = 'leftPosition';
  static const _kFieldPrintMode = 'printMode';
  static const _kFieldReprintMode = 'reprintMode';
  static const _kFieldVirtualDevice = 'virtualDevice';
  static const _kFieldPrinterModelName = 'printerModelName';
  static const _kFieldDeviceFriendlyName = 'deviceFriendlyName';
  static const _kFieldFirmware = 'firmware';
  static const _kFieldLinkOsVersion = 'linkOSVersion';
  static const _kFieldPrinterDpi = 'printerDpi';
  static const _kFieldDevicePrintHeadResolution = 'devicePrintHeadResolution';

  // Writable settings
  /// To set the darkness and relative darkness
  /// Values
  /// "0.0" to "30.0" = darkness
  /// "-0.1" to "-30.0" and "+0.1" to "+30.0" = incremental adjustments
  double? darkness;

  /// Instructs the printer to set the media print speed.
  /// Values
  /// 2-12 inches per second (ips)
  double? printSpeed;

  /// To set the tear-off position
  /// Values
  /// "-120" to "120"
  int? tearOff;

  /// To set the media type used in the printer
  /// Values
  /// • "continuous"
  /// • "gap/notch"
  /// • "mark"
  MediaType? mediaType;

  /// To set the print method.
  /// Values
  /// • "thermal trans"
  /// • "direct thermal"
  PrintMethod? printMethod;

  /// This command sets the print width of the label
  /// Values
  /// any printhead width
  int? printWidth;

  /// Defines the length of the label. This is necessary
  /// when using continuous media (media that is not divided into separate
  /// labels by gaps, spaces, notches, slots, or holes).
  /// Values
  /// 1 to 32000, (in dots) not to exceed the maximum label length.
  /// While the printer accepts any value for this parameter, the amount of
  /// memory installed determines the maximum length of the label.
  ///
  /// Comments
  /// These formulas can be used to determine the value of y:
  /// For 6 dot/mm printheads ---> Label length in inches x 152.4 (dots/inch) = y
  /// For 8 dot/mm printheads ---> Label length in inches x 203.2 (dots/inch) = y
  /// For 12 dot/mm printheads ---> Label length in inches x 304.8 (dots/inch) = y
  /// For 24 dot/mm printheads ---> Label length in inches x 609.6 (dots/inch) = y
  ///
  /// Values for y depend on the memory size. If the entered value for y exceeds
  /// the acceptable limits, the bottom of the label is cut off.
  /// The label also shifts down from top to bottom.
  int? labelLength;

  /// Sets the maximum label length in inches.
  /// Values
  /// 1.0 to 39.0 inches
  double? labelLengthMax;

  /// Sets the ZPL mode.
  /// Values
  /// • "zpl"
  /// • "zpl II"
  ZPLMode? zplMode;

  /// To set the media motion and calibration setting at printer power up
  /// Values
  /// • "feed" = feed to the first web after sensor
  /// • "calibrate" = is used to force a label length measurement and adjust the media and ribbon sensor values.
  /// • "length" = is used to set the label length. Depending on the size of the label, the printer feeds one or more blank labels.
  /// • "no motion" = no media feed
  /// • "short cal" = short calibration
  PowerUpAction? powerUpAction;

  /// This command sets what happens to the media after the printhead is closed
  /// and the printer is taken out of pause.
  /// Values
  /// • "feed" = feed to the first web after sensor
  /// • "calibrate" = is used to force a label length measurement and adjust the media and ribbon sensor values.
  /// • "length" = is used to set the label length. Depending on the size of the label, the printer feeds one or more blank labels.
  /// • "no motion" = no media feed
  /// • "short cal" = short calibration
  HeadCloseAction? headCloseAction;

  /// Sets the label’s top margin offset in dots
  /// Values
  /// "-60 to 60"
  int? labelTop;

  /// Sets the label’s left margin offset in dots.
  /// Values
  /// "-9999 to 9999"
  int? leftPosition;

  /// Sets the print mode
  /// Values
  /// • "tear off"
  /// • "peel off"
  /// • "rewind"
  /// • "cutter"
  /// • "delayed cut"
  /// • "linerless peel"
  /// • "linerless rewind"
  /// • "linerless tear"
  /// • "applicator"
  PrintMode? printMode;

  /// Turns on/off the reprint mode.
  /// Values
  /// • "on"
  /// • "off"
  ReprintMode? reprintMode;

  /// Indicates the Virtual Device in use.
  /// Values
  /// • "none"
  /// • "apl-d"
  /// • "apl-i"
  /// • "apl-e"
  /// • "apl-l"
  /// • "apl-m"
  /// • "apl-mi"
  /// • "apl-o"
  /// • "apl-t"
  /// • "pdf"
  VirtualDevice? virtualDevice;

  // Read only settings
  /// Shows the manufacturer and model name
  final String? printerModelName;

  /// Shows the name assigned to the printer
  final String? deviceFriendlyName;

  /// Shows the printer’s firmware version
  final String? firmware;

  /// Shows the version of the Link-OS TM feature set that is supported by the printer.
  final String? linkOSVersion;

  /// Shows the resolution of the print head in dots per inch as an integer.
  final String? printerDpi;

  /// Shows the resolution of the print head in dots per millimeter (dpmm) as an integer
  /// Valid values are "6dpmm", "8dpmm", "12dpmm", and "24dpmm".
  final String? devicePrintHeadResolution;

  PrinterSettings({
    this.darkness,
    this.printSpeed,
    this.tearOff,
    this.mediaType,
    this.printMethod,
    this.printWidth,
    this.labelLength,
    this.labelLengthMax,
    this.zplMode,
    this.powerUpAction,
    this.headCloseAction,
    this.labelTop,
    this.leftPosition,
    this.printMode,
    this.reprintMode,
    this.virtualDevice,
    this.printerModelName,
    this.deviceFriendlyName,
    this.firmware,
    this.linkOSVersion,
    this.printerDpi,
    this.devicePrintHeadResolution,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        _kFieldDarkness: darkness,
        _kFieldPrintSpeed: printSpeed,
        _kFieldTearOff: tearOff,
        _kFieldMediaType: mediaType?.name,
        _kFieldPrintMethod: printMethod?.name,
        _kFieldPrintWidth: printWidth,
        _kFieldLabelLength: labelLength,
        _kFieldLabelLengthMax: labelLengthMax,
        _kFieldZplMode: zplMode?.name,
        _kFieldPowerUpAction: powerUpAction?.name,
        _kFieldHeadCloseAction: headCloseAction?.name,
        _kFieldLabelTop: labelTop,
        _kFieldLeftPosition: leftPosition,
        _kFieldPrintMode: printMode?.name,
        _kFieldReprintMode: reprintMode?.name,
        _kFieldVirtualDevice: virtualDevice?.name,
        _kFieldPrinterModelName: printerModelName,
        _kFieldDeviceFriendlyName: deviceFriendlyName,
        _kFieldFirmware: firmware,
        _kFieldLinkOsVersion: linkOSVersion,
        _kFieldPrinterDpi: printerDpi,
        _kFieldDevicePrintHeadResolution: devicePrintHeadResolution,
      };

  factory PrinterSettings.fromMap(Map<dynamic, dynamic> map) => PrinterSettings(
        darkness: double.tryParse(map[_kFieldDarkness]),
        printSpeed: double.tryParse(map[_kFieldPrintSpeed]),
        tearOff: int.tryParse(map[_kFieldTearOff]),
        mediaType: MediaTypeUtils.valueOf(map[_kFieldMediaType]),
        printMethod: PrintMethodUtils.valueOf(map[_kFieldPrintMethod]),
        printWidth: int.tryParse(map[_kFieldPrintWidth]),
        labelLength: int.tryParse(map[_kFieldLabelLength]),
        labelLengthMax: double.tryParse(map[_kFieldLabelLengthMax]),
        zplMode: ZPLModeUtils.valueOf(map[_kFieldZplMode]),
        powerUpAction: PowerUpActionUtils.valueOf(map[_kFieldPowerUpAction]),
        headCloseAction: HeadCloseActionUtils.valueOf(map[_kFieldHeadCloseAction]),
        labelTop: int.tryParse(map[_kFieldLabelTop]),
        leftPosition: int.tryParse(map[_kFieldLeftPosition]),
        printMode: PrintModeUtils.valueOf(map[_kFieldPrintMode]),
        reprintMode: ReprintModeUtils.valueOf(map[_kFieldReprintMode]),
        virtualDevice: VirtualDevice.valueOf(map[_kFieldVirtualDevice]),
        printerModelName: map[_kFieldPrinterModelName],
        deviceFriendlyName: map[_kFieldDeviceFriendlyName],
        firmware: map[_kFieldFirmware],
        linkOSVersion: map[_kFieldLinkOsVersion],
        printerDpi: map[_kFieldPrinterDpi],
        devicePrintHeadResolution: map[_kFieldDevicePrintHeadResolution],
      );

  factory PrinterSettings.defaultSettings() => PrinterSettings(
        darkness: 10,
        printSpeed: 6,
        tearOff: 0,
        mediaType: MediaType.mark,
        printMethod: PrintMethod.directThermal,
        printWidth: 568, //600
        labelLength: 1202,
        labelLengthMax: 39,
        zplMode: ZPLMode.zplIi,
        powerUpAction: PowerUpAction.noMotion,
        headCloseAction: HeadCloseAction.noMotion,
        labelTop: 0,
        leftPosition: 0,
        printMode: PrintMode.tearOff,
        reprintMode: ReprintMode.off,
        virtualDevice: VirtualDevice.none,
      );
}
