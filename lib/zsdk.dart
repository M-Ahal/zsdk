import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zsdk/src/enumerators/cause.dart';
import 'package:zsdk/src/enumerators/error_code.dart';
import 'package:zsdk/src/enumerators/orientation.dart';
import 'package:zsdk/src/enumerators/status.dart';
import 'package:zsdk/src/printer_conf.dart';
import 'package:zsdk/src/printer_response.dart';
import 'package:zsdk/src/printer_settings.dart';
import 'package:zsdk/src/status_info.dart';

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

class ZSDK {
  static const int kDefaultZplTcpPort = 9100;

  ///In seconds
  static const int _kDefaultConnectionTimeout = 10;

  /// Channel
  static const String _kMethodChannelName = "zsdk";

  /// Methods
  static const String _kPrintPdfFileOverTcpIp = "printPdfFileOverTCPIP";
  static const String _kPrintPdfDataOverTcpIp = "printPdfDataOverTCPIP";
  static const String _kPrintZplFileOverTcpIp = "printZplFileOverTCPIP";
  static const String _kPrintZplDataOverTcpIp = "printZplDataOverTCPIP";
  static const String _kCheckPrinterStatusOverTcpIp = "checkPrinterStatusOverTCPIP";
  static const String _kGetPrinterSettingsOverTcpIp = "getPrinterSettingsOverTCPIP";
  static const String _kSetPrinterSettingsOverTcpIp = "setPrinterSettingsOverTCPIP";
  static const String _kDoManualCalibrationOverTcpIp = "doManualCalibrationOverTCPIP";
  static const String _kPrintConfigurationLabelOverTcpIp = "printConfigurationLabelOverTCPIP";
  static const String _kRebootPrinterOverTcpIp = "rebootPrinterOverTCPIP";

  /// Properties
  static const String _filePath = "filePath";
  static const String _data = "data";
  static const String _address = "address";
  static const String _port = "port";
  static const String _cmWidth = "cmWidth";
  static const String _cmHeight = "cmHeight";
  static const String _orientation = "orientation";
  static const String _dpi = "dpi";

  late MethodChannel _channel;

  ZSDK() {
    _channel = const MethodChannel(_kMethodChannelName);
    _channel.setMethodCallHandler(_onMethodCall);
  }

  Future<void> _onMethodCall(MethodCall call) async {
    try {
      switch (call.method) {
        default:
          print(call.arguments);
      }
    } catch (e) {
      print(e);
    }
  }

  FutureOr<T> _onTimeout<T>({Duration? timeout}) => throw PlatformException(
      code: ErrorCode.exception.name,
      message:
          "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
      details: PrinterResponse(
        errorCode: ErrorCode.exception,
        message:
            "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
        statusInfo: StatusInfo(
          Status.unknown,
          Cause.noConnection,
        ),
      ).toMap());

  Future doManualCalibrationOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_kDoManualCalibrationOverTcpIp, {
        _address: address,
        _port: port,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printConfigurationLabelOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_kPrintConfigurationLabelOverTcpIp, {
        _address: address,
        _port: port,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future rebootPrinterOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_kRebootPrinterOverTcpIp, {
        _address: address,
        _port: port,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future checkPrinterStatusOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_kCheckPrinterStatusOverTcpIp, {
        _address: address,
        _port: port,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future getPrinterSettingsOverTCPIP({required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_kGetPrinterSettingsOverTcpIp, {
        _address: address,
        _port: port,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future setPrinterSettingsOverTCPIP(
          {required PrinterSettings settings,
          required String address,
          int? port,
          Duration? timeout}) =>
      _channel
          .invokeMethod(
              _kSetPrinterSettingsOverTcpIp,
              {
                _address: address,
                _port: port,
              }..addAll(settings.toMap()))
          .timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
              onTimeout: () => _onTimeout(timeout: timeout));

  Future resetPrinterSettingsOverTCPIP({required String address, int? port, Duration? timeout}) =>
      setPrinterSettingsOverTCPIP(
          settings: PrinterSettings.defaultSettings(),
          address: address,
          port: port,
          timeout: timeout);

  Future printPdfFileOverTCPIP(
          {required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverTCPIP(
          method: _kPrintPdfFileOverTcpIp,
          filePath: filePath,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplFileOverTCPIP(
          {required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverTCPIP(
          method: _kPrintZplFileOverTcpIp,
          filePath: filePath,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future _printFileOverTCPIP(
          {required method,
          required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _filePath: filePath,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printPdfDataOverTCPIP(
          {required ByteData data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printDataOverTCPIP(
          method: _kPrintPdfDataOverTcpIp,
          data: data,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplDataOverTCPIP(
          {required String data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printDataOverTCPIP(
          method: _kPrintZplDataOverTcpIp,
          data: data,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future _printDataOverTCPIP(
          {required method,
          required dynamic data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _data: data,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(timeout ??= const Duration(seconds: _kDefaultConnectionTimeout),
          onTimeout: () => _onTimeout(timeout: timeout));
}
