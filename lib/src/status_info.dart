import 'package:json_annotation/json_annotation.dart';

import 'enumerators/cause.dart';
import 'enumerators/status.dart';
import 'typedefs.dart';

part 'status_info.g.dart';

/// Created by luis901101 on 2020-01-07.
@JsonSerializable()
final class StatusInfo {
  final Status status;
  final Cause cause;

  const StatusInfo(Status? status, Cause? cause)
    : status = status ?? Status.unknown,
      cause = cause ?? Cause.unknown;

  Json toJson() => _$StatusInfoToJson(this);

  factory StatusInfo.fromJson(Json json) => _$StatusInfoFromJson(json);
}
