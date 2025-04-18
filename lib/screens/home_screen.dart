import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:musicapp/providers/audio_provider.dart';
import 'package:musicapp/providers/category_provider.dart';
// import 'package:musicapp/providers/each_category_provider.dart';
import 'package:musicapp/screens/category_data_screen.dart';

import 'package:musicapp/widgets/tab_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  // Replace with your API URL

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size.height;
    final height = size / 5;

    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Container(
        color: Theme.of(context).listTileTheme.tileColor,
        height: height * 1.2,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: ref.read(categoryProvider).length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 100,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CategoryDataScreen(
                                      colours: ref
                                          .read(categoryProvider)[index]
                                          .colours,
                                      title: ref
                                          .read(categoryProvider)[index]
                                          .categoryId,
                                      image: ref
                                          .read(categoryProvider)[index]
                                          .imagePath,
                                    )),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                ref.read(categoryProvider)[index].imagePath,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    ref
                                        .read(categoryProvider)[index]
                                        .categoryId,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const TabBarWidget()
    ]);
  }
}
