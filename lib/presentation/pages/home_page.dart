import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolrandom/core/enum/modos_enum.dart';
import 'package:lolrandom/core/utils/logger.dart';
import 'package:lolrandom/domain/entities/champion.dart';
import 'package:lolrandom/presentation/controllers/composition_controller.dart';
import '../../domain/entities/champion_item.dart';
import '../../providers/items_providers.dart';
import '../controllers/helpers/composition_helpers.dart';
import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';
import '../../data/model/item_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<String> modos = ModosEnum.values.map((e) => e.name).toList();
  String modoSelecionado = 'Solo';
  bool showChampions = false;
  List<ChampionWithItems> campeoesGerados = [];
  List<Champion> campeoesSelecionados = [];

  @override
  Widget build(BuildContext context) {
    final championsAsync = ref.watch(championsProvider);
    final itemsAsync = ref.watch(itemsProvider);

    return SafeArea(
      child: Scaffold(
        drawer: DrawerPersonalizado(),
        appBar: AppBar(
          title: const Text('LoL Champions App'),
          actions: [PopUpMenuPersonalizado()],
        ),
        body: championsAsync.when(
          data: (listaDeChampions) => itemsAsync.when(
            data: (listaDeItems) => SingleChildScrollView(
              child: Column(
                children: [
                  // ToggleButtons
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ToggleButtons(
                        isSelected: modos
                            .map((m) => m == modoSelecionado)
                            .toList(),
                        onPressed: (index) {
                          setState(() {
                            modoSelecionado = modos[index];
                            showChampions = false;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        selectedColor: Colors.white,
                        fillColor: Colors.redAccent,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        constraints: const BoxConstraints(
                          minWidth: 100,
                          minHeight: 40,
                        ),
                        children: modos
                            .map(
                              (modo) => Text(
                                modo,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Mapa
                  Center(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/map/map11.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  showChampions = true;
                                  campeoesGerados.clear();

                                  final random = Random();
                                  final quantidade = quantidadePorModo(
                                    modoSelecionado.toModosEnum(),
                                  );
                                  final shuffledChampions = List<Champion>.from(
                                    listaDeChampions,
                                  )..shuffle();
                                  int champIndex = 0;

                                  quantidade.forEach((rota, qtd) {
                                    for (int i = 0; i < qtd; i++) {
                                      final champ =
                                          shuffledChampions[champIndex %
                                              shuffledChampions.length];
                                      champIndex++;

                                      final boots = listaDeItems
                                          .where(
                                            (i) => i.name
                                                .toLowerCase()
                                                .contains('boot'),
                                          )
                                          .toList();
                                      final otherItems = listaDeItems
                                          .where(
                                            (i) => !i.name
                                                .toLowerCase()
                                                .contains('boot'),
                                          )
                                          .toList();

                                      final items = <ItemModel>[];
                                      if (boots.isNotEmpty) {
                                        items.add(
                                          boots[random.nextInt(boots.length)],
                                        );
                                      }
                                      otherItems.shuffle();
                                      items.addAll(otherItems.take(5));

                                      campeoesGerados.add(
                                        ChampionWithItems(
                                          champion: champ,
                                          items: items,
                                        ),
                                      );
                                    }
                                  });
                                });
                              },
                              splashColor: Colors.black.withAlpha(20),
                              highlightColor: Colors.transparent,
                              child: const SizedBox(width: 350, height: 350),
                            ),
                          ),

                          if (showChampions) ...[
                            // Campeões sobre o mapa
                            ...getChampionsWidgetsFromGenerated(
                              campeoesGerados,
                              rotaPosicoes,
                              quantidadePorModo(modoSelecionado.toModosEnum()),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tabela com campeão + itens
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: // Usa a lista campeoesSelecionados para garantir correspondência exata
                    Column(
                      children: campeoesGerados.map((cwi) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      cwi.champion.imageUrl,
                                      width: 64,
                                      height: 64,
                                    ),
                                    const SizedBox(width: 25),
                                    Text(cwi.champion.name),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: cwi.items
                                      .map(
                                        (item) => Image.network(
                                          item.imageUrl,
                                          width: 48,
                                          height: 48,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) {
              AppLogger.e('Erro nos itens: $e');
              return Center(child: Text("Erro nos itens: $e"));
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Erro nos campeões: $e")),
        ),
      ),
    );
  }
}
