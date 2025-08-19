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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ToggleButtons substituindo os Chips
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
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  selectedColor: Colors.white, // selecionado sempre branco
                  fillColor: Colors.redAccent,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors
                            .white // tema escuro -> texto não selecionado branco
                      : Colors.black, // tema claro -> texto não selecionado preto
                  constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
                  children: modos.map((modo) {
                    return Text(
                      modo,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    );
                  }).toList(),
                ),
              ),
            ),
        
            const SizedBox(height: 100),
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
                    child: const SizedBox(width: 350, height: 350),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
