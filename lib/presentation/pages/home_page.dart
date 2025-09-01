import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolrandom/core/enum/modos_enum.dart';
import 'package:lolrandom/core/utils/logger.dart';
import 'package:lolrandom/presentation/controllers/composition_controller.dart';
import '../controllers/helpers/composition_helpers.dart';
import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<String> modos = ModosEnum.values.map((e) => e.name).toList();
  String modoSelecionado = 'Solo';

  bool showChampions = false; // <--- estado para exibir campeões

  @override
  Widget build(BuildContext context) {
    final championsAsync = ref.watch(championsProvider);

    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(
        title: const Text('LoL Champions App'),
        actions: [PopUpMenuPersonalizado()],
      ),
      body: championsAsync.when(
        data: (listaDeChampions) => SingleChildScrollView(
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
                    isSelected: modos.map((m) => m == modoSelecionado).toList(),
                    onPressed: (index) {
                      setState(() {
                        modoSelecionado = modos[index];
                        AppLogger.i('Modo selecionado: $modoSelecionado');
                        showChampions = false; // esconde até clicar no botão
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

              // Mapa com campeões
              Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      // Mapa
                      Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/map/map11.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              showChampions = true;
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

                      // Campeões só aparecem quando showChampions == true
                      if (showChampions)
                        ...getChampionsWidgets(
                          listaDeChampions,
                          quantidadePorModo(modoSelecionado.toModosEnum()),
                          rotaPosicoes,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Erro: $e")),
      ),
    );
  }
}
