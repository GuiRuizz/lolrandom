import 'package:flutter/material.dart';

import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({super.key});

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  // Mock de campeões com skins
  final List<Map<String, dynamic>> champions = [
    {
      "name": "Ahri",
      "role": "Mid",
      "created": DateTime(2011, 12, 14),
      "skins": ["Classic", "Foxfire", "K/DA", "Spirit Blossom"]
    },
    {
      "name": "Garen",
      "role": "Top",
      "created": DateTime(2010, 4, 27),
      "skins": ["Classic", "Commando", "God-King"]
    },
    {
      "name": "Ezreal",
      "role": "Adc",
      "created": DateTime(2010, 3, 16),
      "skins": ["Classic", "Pulsefire", "Star Guardian", "PsyOps", "Battle Academia"]
    },
  ];

  String _selectedFilter = "Alfabética";

  List<Map<String, dynamic>> get filteredChampions {
    List<Map<String, dynamic>> sorted = List.from(champions);

    switch (_selectedFilter) {
      case "Por rota":
        sorted.sort((a, b) => a["role"].compareTo(b["role"]));
        break;
      case "Por data de criação":
        sorted.sort((a, b) => a["created"].compareTo(b["created"]));
        break;
      case "Por skins habilitadas":
        sorted.sort((b, a) => a["skins"].length.compareTo(b["skins"].length));
        break;
      default: // Alfabética
        sorted.sort((a, b) => a["name"].compareTo(b["name"]));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(
        title: const Text('Skins de Campeões'),
        centerTitle: true,
        actions: [
          PopUpMenuPersonalizado(),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedFilter = value);
                }
              },
              items: const [
                DropdownMenuItem(value: "Alfabética", child: Text("Alfabética")),
                DropdownMenuItem(value: "Por rota", child: Text("Por rota")),
                DropdownMenuItem(value: "Por data de criação", child: Text("Por data de criação")),
                DropdownMenuItem(value: "Por skins habilitadas", child: Text("Por quantidade de skins")),
              ],
            ),
          ),

          // Lista de campeões e skins
          Expanded(
            child: ListView.builder(
              itemCount: filteredChampions.length,
              itemBuilder: (context, index) {
                final champ = filteredChampions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: ExpansionTile(
                    title: Text(
                      champ["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Rota: ${champ["role"]} | Skins: ${champ["skins"].length}"),
                    children: [
                      Wrap(
                        spacing: 8,
                        children: champ["skins"]
                            .map<Widget>(
                              (skin) => ChoiceChip(
                                label: Text(skin),
                                selected: false,
                                onSelected: (_) {
                                  // aqui você pode implementar a seleção da skin
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Selecionou skin: $skin")),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
