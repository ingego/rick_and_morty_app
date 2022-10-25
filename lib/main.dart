import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/view/loading/loading_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Rick & Morty",
      theme: ThemeData(
          textTheme: TextTheme(caption: GoogleFonts.getFont("Jolly Lodger"))),
      home: DefaultTextStyle(
          style: GoogleFonts.getFont("Jolly Lodger"),
          child: const LoadingScreen()),
    );
  }
}
