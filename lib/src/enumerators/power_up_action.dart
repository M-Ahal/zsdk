/// Created by luis901101 on 2020-02-11.
enum PowerUpAction {
  feed,
  calibrate,
  length,
  noMotion,
  shortCal,
}

final _mapValueOfName = {
  'feed': PowerUpAction.feed,
  'calibrate': PowerUpAction.calibrate,
  'length': PowerUpAction.length,
  'no motion': PowerUpAction.noMotion,
  'short cal': PowerUpAction.shortCal,
};

final _mapNameOfValue = {
  PowerUpAction.feed: 'feed',
  PowerUpAction.calibrate: 'calibrate',
  PowerUpAction.length: 'length',
  PowerUpAction.noMotion: 'no motion',
  PowerUpAction.shortCal: 'short cal',
};

extension PowerUpActionUtils on PowerUpAction {
  String get name => _mapNameOfValue[this]!;

  static PowerUpAction? valueOf(String? name) => _mapValueOfName[name!];
}
