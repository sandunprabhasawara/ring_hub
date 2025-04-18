import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:musicapp/models/audio_model.dart';

import 'package:musicapp/providers/favouriteshandler.dart';

import 'package:musicapp/widgets/list_tile.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();

  // final String title;
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  late Future<List<Audio>> _favouriteAudios;

  @override
  void initState() {
    super.initState();
    _favouriteAudios = _loadFavourites();
    print(_favouriteAudios);
  }

  Future<List<Audio>> fetchFavouriteAudios(List<String> ids) async {
    List<Audio> favouriteAudios = [];

    for (String id in ids) {
      final response = await http.get(
        Uri.parse('http://192.168.147.201:8080/audio/single-audio/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final audioJson = data['audio'];
        final audio = Audio.fromJson(audioJson);
        favouriteAudios.add(audio);
      } else {
        debugPrint('Failed to load audio for id: $id');
      }
    }

    return favouriteAudios;
  }

  Future<List<Audio>> _loadFavourites() async {
    final ids = await FavouriteManager.getFavouriteAudioIds(); // your method
    if (ids.isEmpty) return [];
    return await fetchFavouriteAudios(
        ids); // implement this on backend + Flutter
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    List<Widget> mapList(List<Audio> list) => list
        .asMap()
        .entries
        .map((entry) => ListTileWidget(
              title: entry.value.title,
              author: entry.value.profile,
              files: list,
              objectId: entry.value.id,
              id: entry.key,
            ))
        .toList();

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
                          colors: const [Colors.green, Colors.blue])),
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
                        'Favourites',
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
                  SizedBox(
                    child: Container(
                      height: 300,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: FutureBuilder<List<Audio>>(
                        future: _favouriteAudios,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                "No favourites added, try adding some!",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          final audios = snapshot.data!;
                          return Expanded(
                              child: ListView(
                            children: mapList(audios),
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
