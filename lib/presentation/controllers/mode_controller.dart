// lib/presentation/controllers/modo_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enum/modos_enum.dart';

final modoControllerProvider =
    StateNotifierProvider<ModoController, ModosEnum>((ref) {
  return ModoController();
});

class ModoController extends StateNotifier<ModosEnum> {
  ModoController() : super(ModosEnum.solo);

  void selecionarModo(ModosEnum modo) {
    state = modo;
  }
}
