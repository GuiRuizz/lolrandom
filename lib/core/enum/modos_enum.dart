enum ModosEnum {
  solo,
  duo,
  trio,
  jhin,
  fullSquad,
  oneVsOne,
  oneVsFive,
}
extension ModosEnumExtension on ModosEnum {
  String get name {
    switch (this) {
      case ModosEnum.solo:
        return 'Solo';
      case ModosEnum.duo:
        return 'Duo';
      case ModosEnum.trio:
        return 'Trio';
      case ModosEnum.jhin:
        return 'Jhin';
      case ModosEnum.fullSquad:
        return 'Full Squad';
      case ModosEnum.oneVsOne:
        return '1 vs 1';
      case ModosEnum.oneVsFive:
        return '1 vs 5';
    }
  }
}