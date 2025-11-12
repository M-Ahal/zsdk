import 'enumerators/cause.dart';
import 'enumerators/status.dart';
import 'typedefs.dart';

/// Created by luis901101 on 2020-01-07.
final class StatusInfo {
  final Status status;
  final Cause cause;

  const StatusInfo(Status? status, Cause? cause)
    : status = status ?? Status.unknown,
      cause = cause ?? Cause.unknown;

  Json toMap() => {'status': status.name, 'cause': cause.name};

  factory StatusInfo.fromMap(Json map) => StatusInfo(
    map['status'] == null ? null : Status.values.byName(map['status'] as String),
    map['cause'] == null ? null : Cause.values.byName(map['cause'] as String),
  );
}
