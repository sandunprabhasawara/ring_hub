import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp/models/category_model.dart';
import 'package:musicapp/providers/category_provider.dart';
// import 'package:musicapp/providers/each_category_provider.dart';
import 'package:musicapp/screens/category_data_screen.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CategoryDataScreen(
                                      colours: categories[index].colours,
                                      image: categories[index].imagePath,
                                      title: categories[index].categoryId,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: ResizeImage(
                                          AssetImage(ref
                                              .read(categoryProvider)[index]
                                              .imagePath),
                                          width: 500,
                                          height: 500),
                                      fit: BoxFit.cover)),
                            ),
                            Center(
                              child: Text(
                                availableCategories[index]
                                    .categoryId, // Display title from list
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
