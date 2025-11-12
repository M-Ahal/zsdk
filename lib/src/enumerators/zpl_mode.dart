/// Created by luis901101 on 2020-02-11.
enum ZPLMode {
  zpl,
  zplIi,
}

final _mapValueOfName = {
  'zpl': ZPLMode.zpl,
  'zpl II': ZPLMode.zplIi,
};

final _mapNameOfValue = {
  ZPLMode.zpl: 'zpl',
  ZPLMode.zplIi: 'zpl II',
};

extension ZPLModeUtils on ZPLMode {
  String get name => _mapNameOfValue[this]!;

  static ZPLMode? valueOf(String? name) => _mapValueOfName[name!];
}
