import 'package:flutter/material.dart';

import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class Match {
  final String id;
  final String modo;
  final List<String> campeoes; // nomes ou IDs dos campeões
  final List<List<String>> itens; // lista de itens para cada campeão
  final List<String> posicoes; // roles correspondentes a cada campeão

  Match({
    required this.id,
    required this.modo,
    required this.campeoes,
    required this.itens,
    required this.posicoes,
  });
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  List<Match> _mockHistorico() {
    List<Match> historico = [];
    for (int i = 1; i <= 20; i++) {
      historico.add(Match(
        id: 'MATCH${1000 + i}',
        modo: i % 2 == 0 ? '5x5 Ranked' : 'ARAM',
        campeoes: ['Ahri', 'Lee Sin', 'Jinx', 'Leona', 'Thresh'],
        itens: [
          ['Morellonomicon', 'Rabadon', 'Zhonya'],
          ['Warrior', 'Black Cleaver', 'Sterak'],
          ['Infinity Edge', 'Rapid Firecannon', 'Runaan'],
          ['Locket', 'Redemption', 'Knight\'s Vow'],
          ['Shurelya', 'Locket', 'Mikael'],
        ],
        posicoes: ['Mid', 'Jungle', 'ADC', 'Support', 'Support'],
      ));
    }
    return historico;
  }

  @override
  Widget build(BuildContext context) {
    final historico = _mockHistorico();

    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Histórico de Partidas'),
        actions: [PopUpMenuPersonalizado()],

      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: historico.length,
        itemBuilder: (context, index) {
          final partida = historico[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho: ID da partida
                  Text(
                    'Partida: ${partida.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tabela com colunas
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(partida.campeoes.length, (i) {
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Modo: ${partida.modo}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Campeão: ${partida.campeoes[i]}'),
                              const SizedBox(height: 4),
                              Text('Itens: ${partida.itens[i].join(', ')}'),
                              const SizedBox(height: 4),
                              Text('Posição: ${partida.posicoes[i]}'),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
