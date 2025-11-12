/// Created by luis901101 on 2020-02-11.
enum MediaType {
  continuous,
  gapNotch,
  mark,
}

final _mapValueOfName = {
  'continuous': MediaType.continuous,
  'gap/notch': MediaType.gapNotch,
  'mark': MediaType.mark,
};

final _mapNameOfValue = {
  MediaType.continuous: 'continuous',
  MediaType.gapNotch: 'gap/notch',
  MediaType.mark: 'mark',
};

extension MediaTypeUtils on MediaType {
  String get name => _mapNameOfValue[this]!;

  static MediaType? valueOf(String? name) => _mapValueOfName[name!];
}
