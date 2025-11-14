import 'package:json_annotation/json_annotation.dart';

/// Created by luis901101 on 2020-01-09.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum ErrorCode { success, exception, printerError, printerRebooted, unknown }
