/// Created by luis901101 on 2020-02-11.
enum ReprintMode {
  on,
  off,
}

final _mapValueOfName = {
  'on': ReprintMode.on,
  'off': ReprintMode.off,
};

final _mapNameOfValue = {
  ReprintMode.on: 'on',
  ReprintMode.off: 'off',
};

extension ReprintModeUtils on ReprintMode {
  String get name => _mapNameOfValue[this]!;

  static ReprintMode? valueOf(String? name) => _mapValueOfName[name!];
}
