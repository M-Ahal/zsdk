// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusInfo _$StatusInfoFromJson(Map<String, dynamic> json) => StatusInfo(
  $enumDecodeNullable(_$StatusEnumMap, json['status']),
  $enumDecodeNullable(_$CauseEnumMap, json['cause']),
);

Map<String, dynamic> _$StatusInfoToJson(StatusInfo instance) => <String, dynamic>{
  'status': _$StatusEnumMap[instance.status]!,
  'cause': _$CauseEnumMap[instance.cause]!,
};

const _$StatusEnumMap = {
  Status.paused: 'paused',
  Status.readyToPrint: 'readyToPrint',
  Status.unknown: 'unknown',
};

const _$CauseEnumMap = {
  Cause.partialFormatInProgress: 'partialFormatInProgress',
  Cause.headCold: 'headCold',
  Cause.headOpen: 'headOpen',
  Cause.headTooHot: 'headTooHot',
  Cause.paperOut: 'paperOut',
  Cause.ribbonOut: 'ribbonOut',
  Cause.receiveBufferFull: 'receiveBufferFull',
  Cause.noConnection: 'noConnection',
  Cause.unknown: 'unknown',
};
