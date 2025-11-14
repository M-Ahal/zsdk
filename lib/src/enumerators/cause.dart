import 'package:json_annotation/json_annotation.dart';

/// Created by luis901101 on 2020-01-07.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Cause {
  partialFormatInProgress,
  headCold,
  headOpen,
  headTooHot,
  paperOut,
  ribbonOut,
  receiveBufferFull,
  noConnection,
  unknown,
}
