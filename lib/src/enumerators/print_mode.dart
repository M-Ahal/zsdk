/// Created by luis901101 on 2020-02-11.
enum PrintMode {
  tearOff,
  peelOff,
  rewind,
  cutter,
  delayedCut,
  linerlessPeel,
  linerlessRewind,
  linerlessTear,
  applicator,
}

final _mapValueOfName = {
  'tear off': PrintMode.tearOff,
  'peel off': PrintMode.peelOff,
  'rewind': PrintMode.rewind,
  'cutter': PrintMode.cutter,
  'delayed cut': PrintMode.delayedCut,
  'linerless peel': PrintMode.linerlessPeel,
  'linerless rewind': PrintMode.linerlessRewind,
  'linerless tear': PrintMode.linerlessTear,
  'applicator': PrintMode.applicator,
};

final _mapNameOfValue = {
  PrintMode.tearOff: 'tear off',
  PrintMode.peelOff: 'peel off',
  PrintMode.rewind: 'rewind',
  PrintMode.cutter: 'cutter',
  PrintMode.delayedCut: 'delayed cut',
  PrintMode.linerlessPeel: 'linerless peel',
  PrintMode.linerlessRewind: 'linerless rewind',
  PrintMode.linerlessTear: 'linerless tear',
  PrintMode.applicator: 'applicator',
};

extension PrintModeUtils on PrintMode {
  String get name => _mapNameOfValue[this]!;

  static PrintMode? valueOf(String? name) => _mapValueOfName[name!];
}
