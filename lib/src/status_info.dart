import 'enumerators/cause.dart';
import 'enumerators/status.dart';

/// Created by luis901101 on 2020-01-07.
class StatusInfo {
  final Status status;
  final Cause cause;

  StatusInfo(Status? status, Cause? cause)
      : status = status ?? Status.unknown,
        cause = cause ?? Cause.unknown;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'status': status.name,
        'cause': cause.name,
      };

  factory StatusInfo.fromMap(Map<dynamic, dynamic> map) => StatusInfo(
        StatusUtils.valueOf(map['status']),
        CauseUtils.valueOf(map['cause']),
      );
}
