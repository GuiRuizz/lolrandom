import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Supabase.initialize(
    url: "SUA_URL_SUPABASE",
    anonKey: "SUA_ANON_KEY",
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoL Comp Generator',
      home: Scaffold(
        appBar: AppBar(title: const Text("LoL Comp Generator")),
        body: const Center(child: Text("Hello Summoner!")),
      ),
    );
  }
}
