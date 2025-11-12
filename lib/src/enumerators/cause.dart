/// Created by luis901101 on 2020-01-07.
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

extension CauseUtils on Cause {
  String get name => toString().split('.').last;

  static Cause? valueOf(String name) {
    for (final value in Cause.values) {
      if (value.name == name) return value;
    }
    return Cause.unknown;
  }
}
