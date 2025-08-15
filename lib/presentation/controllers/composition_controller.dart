

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/lol_api_datasource.dart';

final compositionProvider = StateNotifierProvider<CompositionController, AsyncValue<List<dynamic>>>(
  (ref) => CompositionController(ref),
);

class CompositionController extends StateNotifier<AsyncValue<List<dynamic>>> {
  final Ref ref;
  CompositionController(this.ref) : super(const AsyncValue.data([]));

  Future<void> fetchChampions() async {
    state = const AsyncValue.loading();
    try {
      final champions = await LolApiDataSource().getChampions();
      state = AsyncValue.data(champions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
