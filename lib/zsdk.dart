import 'dart:async';

import 'package:flutter/services.dart';

import 'src/enumerators/cause.dart';
import 'src/enumerators/error_code.dart';
import 'src/enumerators/status.dart';
import 'src/printer_conf.dart';
import 'src/printer_response.dart';
import 'src/printer_settings.dart';
import 'src/status_info.dart';

export 'package:zsdk/src/enumerators/cause.dart';
export 'package:zsdk/src/enumerators/error_code.dart';
export 'package:zsdk/src/enumerators/head_close_action.dart';
export 'package:zsdk/src/enumerators/media_type.dart';
export 'package:zsdk/src/enumerators/orientation.dart';
export 'package:zsdk/src/enumerators/power_up_action.dart';
export 'package:zsdk/src/enumerators/print_method.dart';
export 'package:zsdk/src/enumerators/print_mode.dart';
export 'package:zsdk/src/enumerators/reprint_mode.dart';
export 'package:zsdk/src/enumerators/status.dart';
export 'package:zsdk/src/enumerators/virtual_device.dart';
export 'package:zsdk/src/enumerators/zpl_mode.dart';
export 'package:zsdk/src/printer_conf.dart';
export 'package:zsdk/src/printer_response.dart';
export 'package:zsdk/src/printer_settings.dart';
export 'package:zsdk/src/status_info.dart';

final class ZSDK {
  static const kDefaultZplTcpPort = 9100;

  ///In seconds
  static const _kDefaultConnectionTimeout = 10;

  /// Channel
  static const _kMethodChannelName = 'zsdk';

  /// Methods
  static const _kPrintPdfFileOverTcpIp = 'printPdfFileOverTCPIP';
  static const _kPrintPdfDataOverTcpIp = 'printPdfDataOverTCPIP';
  static const _kPrintZplFileOverTcpIp = 'printZplFileOverTCPIP';
  static const _kPrintZplDataOverTcpIp = 'printZplDataOverTCPIP';
  static const _kCheckPrinterStatusOverTcpIp = 'checkPrinterStatusOverTCPIP';
  static const _kGetPrinterSettingsOverTcpIp = 'getPrinterSettingsOverTCPIP';
  static const _kSetPrinterSettingsOverTcpIp = 'setPrinterSettingsOverTCPIP';
  static const _kDoManualCalibrationOverTcpIp = 'doManualCalibrationOverTCPIP';
  static const _kPrintConfigurationLabelOverTcpIp = 'printConfigurationLabelOverTCPIP';
  static const _kRebootPrinterOverTcpIp = 'rebootPrinterOverTCPIP';

  /// Properties
  static const _filePath = 'filePath';
  static const _data = 'data';
  static const _address = 'address';
  static const _port = 'port';
  static const _cmWidth = 'cmWidth';
  static const _cmHeight = 'cmHeight';
  static const _orientation = 'orientation';
  static const _dpi = 'dpi';

  final _channel = const MethodChannel(_kMethodChannelName);

  ZSDK() {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  static Future<void> _onMethodCall(MethodCall call) async {
    try {
      switch (call.method) {
        default:
          print(call.arguments);
      }
    } on Exception catch (ex) {
      print(ex);
    }
  }

  static FutureOr<T> _onTimeout<T>({Duration? timeout}) => throw PlatformException(
    code: ErrorCode.exception.name,
    message:
        "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
    details: PrinterResponse(
      errorCode: ErrorCode.exception,
      message:
          "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
      statusInfo: const StatusInfo(Status.unknown, Cause.noConnection),
    ).toMap(),
  );

  Future doManualCalibrationOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel
          .invokeMethod(_kDoManualCalibrationOverTcpIp, {_address: address, _port: port})
          .timeout(
            timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
            onTimeout: () => _onTimeout(timeout: timeout),
          );

  Future printConfigurationLabelOverTCPIP({
    required String address,
    int? port,
    Duration? timeout,
  }) => _channel
      .invokeMethod(_kPrintConfigurationLabelOverTcpIp, {_address: address, _port: port})
      .timeout(
        timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
        onTimeout: () => _onTimeout(timeout: timeout),
      );

  Future rebootPrinterOverTCPIP({required String address, int? port, Duration? timeout}) => _channel
      .invokeMethod(_kRebootPrinterOverTcpIp, {_address: address, _port: port})
      .timeout(
        timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
        onTimeout: () => _onTimeout(timeout: timeout),
      );

  Future checkPrinterStatusOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel
          .invokeMethod(_kCheckPrinterStatusOverTcpIp, {_address: address, _port: port})
          .timeout(
            timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
            onTimeout: () => _onTimeout(timeout: timeout),
          );

  Future getPrinterSettingsOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel
          .invokeMethod(_kGetPrinterSettingsOverTcpIp, {_address: address, _port: port})
          .timeout(
            timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
            onTimeout: () => _onTimeout(timeout: timeout),
          );

  Future setPrinterSettingsOverTCPIP({
    required PrinterSettings settings,
    required String address,
    int? port,
    Duration? timeout,
  }) => _channel
      .invokeMethod(
        _kSetPrinterSettingsOverTcpIp,
        {_address: address, _port: port}..addAll(settings.toJson()),
      )
      .timeout(
        timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
        onTimeout: () => _onTimeout(timeout: timeout),
      );

  Future resetPrinterSettingsOverTCPIP({required String address, int? port, Duration? timeout}) =>
      setPrinterSettingsOverTCPIP(
        settings: PrinterSettings.defaultSettings(),
        address: address,
        port: port,
        timeout: timeout,
      );

  Future printPdfFileOverTCPIP({
    required String filePath,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _printFileOverTCPIP(
    methodName: _kPrintPdfFileOverTcpIp,
    filePath: filePath,
    address: address,
    port: port,
    printerConf: printerConf,
    timeout: timeout,
  );

  Future printZplFileOverTCPIP({
    required String filePath,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _printFileOverTCPIP(
    methodName: _kPrintZplFileOverTcpIp,
    filePath: filePath,
    address: address,
    port: port,
    printerConf: printerConf,
    timeout: timeout,
  );

  Future _printFileOverTCPIP({
    required String methodName,
    required String filePath,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _channel
      .invokeMethod(methodName, {
        _filePath: filePath,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      })
      .timeout(
        timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
        onTimeout: () => _onTimeout(timeout: timeout),
      );

  Future printPdfDataOverTCPIP({
    required ByteData data,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _printDataOverTCPIP(
    methodName: _kPrintPdfDataOverTcpIp,
    data: data,
    address: address,
    port: port,
    printerConf: printerConf,
    timeout: timeout,
  );

  Future printZplDataOverTCPIP({
    required String data,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _printDataOverTCPIP(
    methodName: _kPrintZplDataOverTcpIp,
    data: data,
    address: address,
    port: port,
    printerConf: printerConf,
    timeout: timeout,
  );

  Future _printDataOverTCPIP({
    required String methodName,
    required data,
    required String address,
    int? port,
    PrinterConf? printerConf,
    Duration? timeout,
  }) => _channel
      .invokeMethod(methodName, {
        _data: data,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      })
      .timeout(
        timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
        onTimeout: () => _onTimeout(timeout: timeout),
      );
}
