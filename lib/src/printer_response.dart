import 'enumerators/cause.dart';
import 'enumerators/error_code.dart';
import 'enumerators/status.dart';
import 'printer_settings.dart';
import 'status_info.dart';
import 'typedefs.dart';

/// Created by luis901101 on 2020-01-07.
final class PrinterResponse {
  final ErrorCode errorCode;
  final StatusInfo statusInfo;
  final PrinterSettings? settings;
  final String? message;

  const PrinterResponse({ErrorCode? errorCode, StatusInfo? statusInfo, this.settings, this.message})
    : errorCode = errorCode ?? ErrorCode.unknown,
      statusInfo = statusInfo ?? const StatusInfo(Status.unknown, Cause.unknown);

  Json toMap() => {
    'errorCode': errorCode.name,
    'statusInfo': statusInfo.toMap(),
    'settings': settings?.toMap(),
    'message': message,
  };

  factory PrinterResponse.fromMap(Json map) => PrinterResponse(
    errorCode: ErrorCode.values.byName(map['errorCode'] as String),
    statusInfo: map['statusInfo'] == null ? null : StatusInfo.fromMap(map['statusInfo'] as Json),
    settings: map['settings'] == null ? null : PrinterSettings.fromMap(map['settings'] as Json),
    message: map['message'] as String?,
  );
}
