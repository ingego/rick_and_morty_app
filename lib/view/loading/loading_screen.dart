import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_and_morty_app/view/main/screen.dart';
import 'package:rick_and_morty_app/view/widgets/screens.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Screen(
        child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 4)),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                Future.microtask(() => MainScreen.callMe(context));
              }
              return const _OnLoading();
            }));
  }
}

class _OnLoading extends ConsumerWidget {
  const _OnLoading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "SCHWIFTY",
            style: GoogleFonts.getFont("Jolly Lodger")
                .copyWith(fontSize: 64, color: Colors.white),
          ),
        ),
        LottieBuilder.asset(r"assets/anime/morty.json"),
        Center(
          child: Text(
            "Char, Loc, Eps",
            style: GoogleFonts.getFont("Jolly Lodger")
                .copyWith(fontSize: 64, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
