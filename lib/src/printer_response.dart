import 'package:json_annotation/json_annotation.dart';

import 'enumerators/cause.dart';
import 'enumerators/error_code.dart';
import 'enumerators/status.dart';
import 'printer_settings.dart';
import 'status_info.dart';
import 'typedefs.dart';

part 'printer_response.g.dart';

/// Created by luis901101 on 2020-01-07.
@JsonSerializable()
final class PrinterResponse {
  final ErrorCode errorCode;
  final StatusInfo statusInfo;
  final PrinterSettings? settings;
  final String? message;

  const PrinterResponse({ErrorCode? errorCode, StatusInfo? statusInfo, this.settings, this.message})
    : errorCode = errorCode ?? ErrorCode.unknown,
      statusInfo = statusInfo ?? const StatusInfo(Status.unknown, Cause.unknown);

  Json toMap() => _$PrinterResponseToJson(this);

  factory PrinterResponse.fromJson(Json json) => _$PrinterResponseFromJson(json);
}
