import 'package:alt_rick_and_morty/rick_and_morty_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/view/widgets/screens.dart';

final _rickProvider = FutureProvider<Character?>((ref) async {
  return CharacterManager().getCharacter(id: 1);
});

final _finderProvider = StateProvider<String>((ref) {
  return "";
});

final _CharsProvider = FutureProvider<List<Character>>((ref) async {
  return CharacterManager()
      .getFilteredCharacters(name: ref.watch(_finderProvider));
});

class MainScreen extends ConsumerWidget {
  static Future callMe(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Screen(
        child: Column(
      children: [
        Expanded(
            child: Center(
          child: ref.watch(_rickProvider).when(
              data: (data) {
                if (data == null) {
                  return const Text("Ошибка персонажа"); // TODO Локализация

                }
                return SizedBox.square(
                  dimension: 200,
                  child: Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                        image: NetworkImage(
                          data.image,
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(32),
                  )),
                );
              },
              error: ((error, stackTrace) => (Text(error.toString()))),
              loading: () => const CircularProgressIndicator()),
        )),
        const Expanded(flex: 2, child: _Body())
      ],
    ));
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            onChanged: (s) {
              ref.read(_finderProvider.notifier).state = s;
            },
            decoration:
                const InputDecoration(enabledBorder: OutlineInputBorder()),
          ),
          Consumer(builder: (context, ref, _) {
            return Expanded(
                child: ref.watch(_CharsProvider).when(
                    data: (data) {
                      return SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 5,
                          spacing: 10,
                          direction: Axis.horizontal,
                          children: [
                            ...List.generate(
                                data.length,
                                (index) => SizedBox.square(
                                      dimension:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data[index].image),
                                                fit: BoxFit.fill)),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            data[index].name,
                                            style: GoogleFonts.getFont(
                                                    "Jolly Lodger")
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                          ),
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      );
                    },
                    error: (e, s) => Text("$e"),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )));
          })
        ],
      ),
    );
  }
}
