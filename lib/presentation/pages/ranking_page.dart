import 'package:flutter/material.dart';

import '../../core/utils/logger.dart';
import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class Player {
  final int rank;
  final String nickname;
  final String elo;
  final int points;

  Player({
    required this.rank,
    required this.nickname,
    required this.elo,
    required this.points,
  });
}

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  // Lista mockada de 100 jogadores
  List<Player> _mockTopPlayers() {
    final elos = ['Challenger', 'Grandmaster', 'Master', 'Diamond', 'Platinum', 'Gold', 'Silver', 'Bronze'];
    List<Player> players = [];
    for (int i = 1; i <= 100; i++) {
      players.add(
        Player(
          rank: i,
          nickname: 'Player$i',
          elo: elos[(i ~/ 13).clamp(0, elos.length - 1)], // distribui os elos
          points: 1000 - i * 5, // mock de pontos
        ),
      );
    }
    return players;
  }

  Color _eloColor(String elo) {
    switch (elo) {
      case 'Challenger':
        return Colors.redAccent;
      case 'Grandmaster':
        return Colors.deepPurple;
      case 'Master':
        return Colors.purple;
      case 'Diamond':
        return Colors.blueAccent;
      case 'Platinum':
        return Colors.teal;
      case 'Gold':
        return Colors.amber;
      case 'Silver':
        return Colors.grey;
      case 'Bronze':
        return Colors.brown;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final players = _mockTopPlayers();

    return SafeArea(
      child: Scaffold(
        drawer: DrawerPersonalizado(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Ranking',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Icon(Icons.emoji_events, color: Colors.yellow[700]),
            ],
          ),
          actions: [PopUpMenuPersonalizado()],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: players.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final player = players[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: _eloColor(player.elo),
                child: Text(player.rank.toString(), style: const TextStyle(color: Colors.white)),
              ),
              title: Text(player.nickname),
              subtitle: Text('${player.elo} • ${player.points} LP'),
              trailing: Icon(Icons.emoji_events, color: _eloColor(player.elo)),
              onTap: () {
                AppLogger.i('Jogador selecionado: ${player.nickname}');
                // Aqui você pode adicionar a navegação para uma página de detalhes do jogador, se necessário
              },
            );
          },
        ),
      ),
    );
  }
}
