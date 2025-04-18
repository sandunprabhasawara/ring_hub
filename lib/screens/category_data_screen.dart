import 'package:flutter/material.dart';

import 'package:musicapp/models/audio_model.dart';
import 'package:musicapp/providers/audio_provider.dart';
// import 'package:musicapp/screens/audio_screen.dart';
import 'package:musicapp/widgets/list_tile.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:musicapp/providers/each_category_provider.dart';

class CategoryDataScreen extends ConsumerWidget {
  const CategoryDataScreen(
      {super.key,
      required this.colours,
      required this.image,
      required this.title});

  final String title;
  final String image;
  final List<Color> colours;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(title);
    final filteredAudiofiles = ref.watch(filteredAudioProvider(title));
    print(filteredAudiofiles);
    final height = MediaQuery.of(context).size.height;
    List<Widget> filterdAudioPlaylists =
        filteredAudiofiles.asMap().entries.map((entry) {
      int index = entry.key;
      Audio audio = entry.value;
      return ListTileWidget(
          title: audio.title,
          author: audio.profile,
          files: filteredAudiofiles,
          objectId: audio.id,
          id: index);
    }).toList();

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: (height / 5) * 1.5,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: (height / 5) * 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colours)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text('data'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              elevation: 0,
              leading: null,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 15, // specify the height you want
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: filterdAudioPlaylists.isEmpty
                        ? Center(
                            child: Text(
                              "No audios found in this category",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Column(children: filterdAudioPlaylists),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
