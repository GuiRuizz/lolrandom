import 'package:logger/logger.dart';

class AppLogger {
  // Cria uma instância singleton do Logger
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // quantas linhas do stack trace mostrar
      errorMethodCount: 5, // linhas de stack trace para erros
      lineLength: 80, // comprimento da linha
      colors: true, // habilita cores no console
      printEmojis: true, // emojis para cada nível de log
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // imprime timestamp
    ),
  );

  // Métodos de log
  static void d(dynamic message) {
    _logger.d(message);
  }

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void t(dynamic message) {
    _logger.t(message);
  }

  static void wtf(dynamic message) {
    _logger.f(message);
  }
}
