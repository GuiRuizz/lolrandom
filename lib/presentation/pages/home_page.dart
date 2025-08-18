import 'package:flutter/material.dart';
import 'package:lolrandom/core/utils/logger.dart';

import '../widgets/drawer_personalizado.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> modos = [
    'Solo',
    'Time 3x3',
    'Time 5x5',
    '1x1',
    '3x3',
    '5x5',
  ];
  String modoSelecionado = 'Solo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(
        title: const Text('LoL Champions App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chips em múltiplas linhas se necessário
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Wrap(
              spacing: 8, // espaço horizontal entre chips
              runSpacing: 8, // espaço vertical entre linhas
              alignment: WrapAlignment.center, // centraliza os chips
              children: modos.map((modo) {
                return Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  child: ChoiceChip(
                    label: Text(
                      modo,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    selected: modoSelecionado == modo,
                    onSelected: (_) {
                      setState(() {
                        modoSelecionado = modo;
                        AppLogger.i('Modo selecionado: $modoSelecionado');
                      });
                    },
                    selectedColor: Colors.blueAccent,
                    backgroundColor: Colors.grey[300],
                    labelStyle: TextStyle(
                      color: modoSelecionado == modo
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                    ),
                    labelPadding: EdgeInsets.zero, // remove padding interno
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // ajusta target ao tamanho
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          // Mapa
          Center(
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: Ink(
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
                    AppLogger.i('Mapa clicado no modo: $modoSelecionado');
                  },
                  splashColor: Colors.black.withAlpha(20),
                  highlightColor: Colors.transparent,
                  child: const SizedBox(width: 300, height: 300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
