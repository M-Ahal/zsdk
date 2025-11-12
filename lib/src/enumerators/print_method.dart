/// Created by luis901101 on 2020-02-11.
enum PrintMethod {
  thermalTrans,
  directThermal,
}

final _mapValueOfName = {
  'thermal trans': PrintMethod.thermalTrans,
  'direct thermal': PrintMethod.directThermal,
};

final _mapNameOfValue = {
  PrintMethod.thermalTrans: 'thermal trans',
  PrintMethod.directThermal: 'direct thermal',
};

extension PrintMethodUtils on PrintMethod {
  String get name => _mapNameOfValue[this]!;

  static PrintMethod? valueOf(String? name) => _mapValueOfName[name!];
}
