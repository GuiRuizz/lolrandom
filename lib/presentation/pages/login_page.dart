import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riotAuth = ref.read(riotAuthProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg/wallpaper.png', fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 105.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd0373a),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  final userData = await riotAuth.login();
                  //TODO: voltar para != (somente para dev)
                  if (userData == null) {
                    ref.read(riotUserProvider.notifier).state = userData;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login realizado!")),
                    );
                    context.push('/inicial');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Falha no login.")),
                    );
                  }
                },
                child: Text(
                  "Login com Riot Account",
                  style: GoogleFonts.prata(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
