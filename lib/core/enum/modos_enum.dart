enum ModosEnum {
  solo,
  duo,
  trio,
  jhin,
  fullSquad,
  oneVsOne,
  threeVsThree,
  jhinVsJhin,
  fiveVsFive,
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
      case ModosEnum.threeVsThree:
        return '3 vs 3';
      case ModosEnum.jhinVsJhin:
        return 'Jhin vs Jhin';
      case ModosEnum.fiveVsFive:
        return '5 vs 5';
      case ModosEnum.oneVsFive:
        return '1 vs 5';
    }
  }
}