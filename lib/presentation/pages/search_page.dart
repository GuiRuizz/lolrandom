import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/composition_controller.dart';
import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final championsAsync = ref.watch(championsProvider);

    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(
        title: const Text('Campeões'),
        centerTitle: true,
        actions: [
          PopUpMenuPersonalizado(),
        ],
      ),
      body: championsAsync.when(
        data: (champs) => ListView.builder(
          itemCount: champs.length,
          itemBuilder: (context, index) {
            final champ = champs[index];
            return ListTile(
              leading: Image.network(champ.imageUrl, width: 40, height: 40),
              title: Text(champ.name),
              subtitle: Text(champ.title),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Erro: $e")),
      ),
    );
  }
}
