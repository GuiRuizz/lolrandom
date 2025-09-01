import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolrandom/core/enum/modos_enum.dart';
import 'package:lolrandom/core/utils/logger.dart';
import 'package:lolrandom/presentation/controllers/composition_controller.dart';
import '../../data/model/champion_model.dart';
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

  Map<String, List<ItemModel>> campeaoItens = {};

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

                                  // Gera os itens aleatórios por campeão
                                  final random = Random();
                                  campeaoItens.clear();

                                  final quantidade = quantidadePorModo(
                                    modoSelecionado.toModosEnum(),
                                  );
                                  int champIndex = 0;

                                  quantidade.forEach((rota, qtd) {
                                    for (int i = 0; i < qtd; i++) {
                                      final champ =
                                          listaDeChampions[champIndex %
                                              listaDeChampions.length];
                                      champIndex++;

                                      // 6 itens aleatórios, obrigatoriamente uma bota
                                      final itensAleatorios = <ItemModel>[];
                                      final boots = listaDeItems
                                          .where(
                                            (i) => i.name
                                                .toLowerCase()
                                                .contains('boot'),
                                          )
                                          .toList();
                                      if (boots.isNotEmpty) {
                                        itensAleatorios.add(
                                          boots[random.nextInt(boots.length)],
                                        );
                                      }

                                      while (itensAleatorios.length < 6) {
                                        final item =
                                            listaDeItems[random.nextInt(
                                              listaDeItems.length,
                                            )];
                                        if (!itensAleatorios.contains(item)) {
                                          itensAleatorios.add(item);
                                        }
                                      }

                                      campeaoItens[champ.name] =
                                          itensAleatorios;
                                    }
                                  });
                                });

                                AppLogger.i(
                                  'Mapa clicado no modo: $modoSelecionado',
                                );
                              },
                              splashColor: Colors.black.withAlpha(20),
                              highlightColor: Colors.transparent,
                              child: const SizedBox(width: 350, height: 350),
                            ),
                          ),

                          if (showChampions) ...[
                            // Campeões sobre o mapa
                            ...getChampionsWidgets(
                              listaDeChampions,
                              quantidadePorModo(modoSelecionado.toModosEnum()),
                              rotaPosicoes,
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
                    child: Column(
                      children: campeaoItens.entries.map((entry) {
                        final champName = entry.key;
                        final items = entry.value;

                        // Procura o objeto Champion para pegar a imagem
                        final champ = listaDeChampions.firstWhere(
                          (c) => c.name == champName,
                          orElse: () => ChampionModel(
                            id: listaDeChampions.first.id,
                            name: listaDeChampions.first.name,
                            title: listaDeChampions.first.title,
                            imageUrl: listaDeChampions.first.imageUrl,
                          ),
                        );

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                // Linha com imagem + nome do campeão
                                Row(
                                  children: [
                                    Image.network(
                                      champ.imageUrl,
                                      width: 64,
                                      height: 64,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      champ.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Linha com os 6 itens
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: items.map((item) {
                                    return Column(
                                      children: [
                                        Image.network(
                                          item.imageUrl,
                                          width: 48,
                                          height: 48,
                                        ),
                                        SizedBox(
                                          width: 50,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
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
