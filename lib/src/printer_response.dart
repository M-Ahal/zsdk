import 'enumerators/cause.dart';
import 'enumerators/error_code.dart';
import 'enumerators/status.dart';
import 'printer_settings.dart';
import 'status_info.dart';

/// Created by luis901101 on 2020-01-07.
class PrinterResponse {
  ErrorCode errorCode;
  StatusInfo statusInfo;
  PrinterSettings? settings;
  String? message;

  PrinterResponse({ErrorCode? errorCode, StatusInfo? statusInfo, this.settings, this.message})
      : errorCode = errorCode ?? ErrorCode.unknown,
        statusInfo = statusInfo ?? StatusInfo(Status.unknown, Cause.unknown);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'errorCode': errorCode.name,
        'statusInfo': statusInfo.toMap(),
        'settings': settings?.toMap(),
        'message': message,
      };

  factory PrinterResponse.fromMap(Map<dynamic, dynamic> map) => PrinterResponse(
        errorCode: ErrorCode.values.byName(map['errorCode']),
        statusInfo: map['statusInfo'] == null ? null : StatusInfo.fromMap(map['statusInfo']),
        settings: map['settings'] == null ? null : PrinterSettings.fromMap(map['settings']),
        message: map['message'],
      );
}
