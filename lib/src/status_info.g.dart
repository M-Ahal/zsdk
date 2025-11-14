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
  Status.paused: 'PAUSED',
  Status.readyToPrint: 'READY_TO_PRINT',
  Status.unknown: 'UNKNOWN',
};

const _$CauseEnumMap = {
  Cause.partialFormatInProgress: 'PARTIAL_FORMAT_IN_PROGRESS',
  Cause.headCold: 'HEAD_COLD',
  Cause.headOpen: 'HEAD_OPEN',
  Cause.headTooHot: 'HEAD_TOO_HOT',
  Cause.paperOut: 'PAPER_OUT',
  Cause.ribbonOut: 'RIBBON_OUT',
  Cause.receiveBufferFull: 'RECEIVE_BUFFER_FULL',
  Cause.noConnection: 'NO_CONNECTION',
  Cause.unknown: 'UNKNOWN',
};
