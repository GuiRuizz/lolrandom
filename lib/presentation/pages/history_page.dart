import 'package:flutter/material.dart';

import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class Match {
  final String id;
  final String modo;
  final List<String> campeoes; 
  final List<List<String>> itens;
  final List<String> posicoes;

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
      historico.add(
        Match(
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
        ),
      );
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

          // 🔹 No futuro: pegará o campeão do usuário logado
          const int userChampionIndex = 0; // mockado Ahri

          return Card(
            color: Colors.grey[900],
            elevation: 3,
            shadowColor: Colors.blueAccent.withAlpha(30),
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Cabeçalho
                  Center(
                    child: Text(
                      partida.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      partida.modo,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🔹 Linha com Campeão / Itens / Posição
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Campeão
                      Column(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            partida.campeoes[userChampionIndex],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      // Itens
                      Column(
                        children: [
                          Row(
                            children: partida.itens[userChampionIndex]
                                .map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.grey,
                                            child: Icon(Icons.inventory,
                                                size: 16, color: Colors.white),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(item,
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Itens",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),

                      // Posição
                      Column(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.map, color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            partida.posicoes[userChampionIndex],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
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
