// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrinterSettings _$PrinterSettingsFromJson(Map<String, dynamic> json) => PrinterSettings(
  darkness: (json['darkness'] as num?)?.toDouble(),
  printSpeed: (json['printSpeed'] as num?)?.toDouble(),
  tearOff: (json['tearOff'] as num?)?.toInt(),
  mediaType: $enumDecodeNullable(_$MediaTypeEnumMap, json['mediaType']),
  printMethod: $enumDecodeNullable(_$PrintMethodEnumMap, json['printMethod']),
  printWidth: (json['printWidth'] as num?)?.toInt(),
  labelLength: (json['labelLength'] as num?)?.toInt(),
  labelLengthMax: (json['labelLengthMax'] as num?)?.toDouble(),
  zplMode: $enumDecodeNullable(_$ZPLModeEnumMap, json['zplMode']),
  powerUpAction: $enumDecodeNullable(_$PowerUpActionEnumMap, json['powerUpAction']),
  headCloseAction: $enumDecodeNullable(_$HeadCloseActionEnumMap, json['headCloseAction']),
  labelTop: (json['labelTop'] as num?)?.toInt(),
  leftPosition: (json['leftPosition'] as num?)?.toInt(),
  printMode: $enumDecodeNullable(_$PrintModeEnumMap, json['printMode']),
  reprintMode: $enumDecodeNullable(_$ReprintModeEnumMap, json['reprintMode']),
  virtualDevice: $enumDecodeNullable(_$VirtualDeviceEnumMap, json['virtualDevice']),
  printerModelName: json['printerModelName'] as String?,
  deviceFriendlyName: json['deviceFriendlyName'] as String?,
  firmware: json['firmware'] as String?,
  linkOSVersion: json['linkOSVersion'] as String?,
  printerDpi: json['printerDpi'] as String?,
  devicePrintHeadResolution: json['devicePrintHeadResolution'] as String?,
);

Map<String, dynamic> _$PrinterSettingsToJson(PrinterSettings instance) => <String, dynamic>{
  'darkness': instance.darkness,
  'printSpeed': instance.printSpeed,
  'tearOff': instance.tearOff,
  'mediaType': _$MediaTypeEnumMap[instance.mediaType],
  'printMethod': _$PrintMethodEnumMap[instance.printMethod],
  'printWidth': instance.printWidth,
  'labelLength': instance.labelLength,
  'labelLengthMax': instance.labelLengthMax,
  'zplMode': _$ZPLModeEnumMap[instance.zplMode],
  'powerUpAction': _$PowerUpActionEnumMap[instance.powerUpAction],
  'headCloseAction': _$HeadCloseActionEnumMap[instance.headCloseAction],
  'labelTop': instance.labelTop,
  'leftPosition': instance.leftPosition,
  'printMode': _$PrintModeEnumMap[instance.printMode],
  'reprintMode': _$ReprintModeEnumMap[instance.reprintMode],
  'virtualDevice': _$VirtualDeviceEnumMap[instance.virtualDevice],
  'printerModelName': instance.printerModelName,
  'deviceFriendlyName': instance.deviceFriendlyName,
  'firmware': instance.firmware,
  'linkOSVersion': instance.linkOSVersion,
  'printerDpi': instance.printerDpi,
  'devicePrintHeadResolution': instance.devicePrintHeadResolution,
};

const _$MediaTypeEnumMap = {
  MediaType.continuous: 'continuous',
  MediaType.gapNotch: 'gapNotch',
  MediaType.mark: 'mark',
};

const _$PrintMethodEnumMap = {
  PrintMethod.thermalTrans: 'thermalTrans',
  PrintMethod.directThermal: 'directThermal',
};

const _$ZPLModeEnumMap = {ZPLMode.zpl: 'zpl', ZPLMode.zplIi: 'zplIi'};

const _$PowerUpActionEnumMap = {
  PowerUpAction.feed: 'feed',
  PowerUpAction.calibrate: 'calibrate',
  PowerUpAction.length: 'length',
  PowerUpAction.noMotion: 'noMotion',
  PowerUpAction.shortCal: 'shortCal',
};

const _$HeadCloseActionEnumMap = {
  HeadCloseAction.feed: 'feed',
  HeadCloseAction.calibrate: 'calibrate',
  HeadCloseAction.length: 'length',
  HeadCloseAction.noMotion: 'noMotion',
  HeadCloseAction.shortCal: 'shortCal',
};

const _$PrintModeEnumMap = {
  PrintMode.tearOff: 'tearOff',
  PrintMode.peelOff: 'peelOff',
  PrintMode.rewind: 'rewind',
  PrintMode.cutter: 'cutter',
  PrintMode.delayedCut: 'delayedCut',
  PrintMode.linerlessPeel: 'linerlessPeel',
  PrintMode.linerlessRewind: 'linerlessRewind',
  PrintMode.linerlessTear: 'linerlessTear',
  PrintMode.applicator: 'applicator',
};

const _$ReprintModeEnumMap = {ReprintMode.on: 'on', ReprintMode.off: 'off'};

const _$VirtualDeviceEnumMap = {
  VirtualDevice.none: 'none',
  VirtualDevice.aplD: 'aplD',
  VirtualDevice.aplI: 'aplI',
  VirtualDevice.aplE: 'aplE',
  VirtualDevice.aplL: 'aplL',
  VirtualDevice.aplM: 'aplM',
  VirtualDevice.aplMi: 'aplMi',
  VirtualDevice.aplO: 'aplO',
  VirtualDevice.aplT: 'aplT',
  VirtualDevice.pdf: 'pdf',
};
