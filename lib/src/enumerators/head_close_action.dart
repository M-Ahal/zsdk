/// Created by luis901101 on 2020-02-11.
enum HeadCloseAction {
  feed,
  calibrate,
  length,
  noMotion,
  shortCal,
}

final _mapValueOfName = {
  'feed': HeadCloseAction.feed,
  'calibrate': HeadCloseAction.calibrate,
  'length': HeadCloseAction.length,
  'no motion': HeadCloseAction.noMotion,
  'short cal': HeadCloseAction.shortCal,
};

final _mapNameOfValue = {
  HeadCloseAction.feed: 'feed',
  HeadCloseAction.calibrate: 'calibrate',
  HeadCloseAction.length: 'length',
  HeadCloseAction.noMotion: 'no motion',
  HeadCloseAction.shortCal: 'short cal',
};

extension HeadCloseActionUtils on HeadCloseAction {
  String get name => _mapNameOfValue[this]!;

  static HeadCloseAction? valueOf(String? name) => _mapValueOfName[name];
}
