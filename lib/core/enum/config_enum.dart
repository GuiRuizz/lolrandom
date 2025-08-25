import 'package:flutter/material.dart';

enum ConfigEnum { sistema, claro, escuro }

extension ConfigEnumExtension on ConfigEnum {
  String get label {
    switch (this) {
      case ConfigEnum.sistema:
        return 'Sistema';
      case ConfigEnum.claro:
        return 'Sempre Claro';
      case ConfigEnum.escuro:
        return 'Sempre Escuro';
    }
  }

  /// Converte `ConfigEnum` -> `ThemeMode`
  ThemeMode get toThemeMode {
    switch (this) {
      case ConfigEnum.sistema:
        return ThemeMode.system;
      case ConfigEnum.claro:
        return ThemeMode.light;
      case ConfigEnum.escuro:
        return ThemeMode.dark;
    }
  }

  /// Converte `ThemeMode` -> `ConfigEnum`
  static ConfigEnum fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return ConfigEnum.sistema;
      case ThemeMode.light:
        return ConfigEnum.claro;
      case ThemeMode.dark:
        return ConfigEnum.escuro;
    }
  }
}
