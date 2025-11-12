// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrinterResponse _$PrinterResponseFromJson(Map<String, dynamic> json) => PrinterResponse(
  errorCode: $enumDecodeNullable(_$ErrorCodeEnumMap, json['errorCode']),
  statusInfo: json['statusInfo'] == null
      ? null
      : StatusInfo.fromJson(json['statusInfo'] as Map<String, dynamic>),
  settings: json['settings'] == null
      ? null
      : PrinterSettings.fromJson(json['settings'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$PrinterResponseToJson(PrinterResponse instance) => <String, dynamic>{
  'errorCode': _$ErrorCodeEnumMap[instance.errorCode]!,
  'statusInfo': instance.statusInfo,
  'settings': instance.settings,
  'message': instance.message,
};

const _$ErrorCodeEnumMap = {
  ErrorCode.success: 'success',
  ErrorCode.exception: 'exception',
  ErrorCode.printerError: 'printerError',
  ErrorCode.printerRebooted: 'printerRebooted',
  ErrorCode.unknown: 'unknown',
};
