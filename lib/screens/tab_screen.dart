import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:musicapp/models/audio_model.dart';
import 'package:musicapp/providers/navigation/nav_notifier.dart';

// Custom imports
import 'package:musicapp/screens/category_screen.dart';
import 'package:musicapp/screens/favorite_screen.dart';
import 'package:musicapp/screens/home_screen.dart';
import 'package:musicapp/screens/user_screen.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  static final List<Widget> _widgetOptions = [
    HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const UserScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: _widgetOptions[navIndex.index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: navIndex.index,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white30,
          onTap: (value) {
            ref.read(navProvider.notifier).onIndexChanged(value);
          },
          unselectedIconTheme:
              const IconThemeData().copyWith(color: Colors.white30),
          iconSize: 24,
          selectedFontSize: 12.0,
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.green,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.queue_music), label: 'catogories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), label: 'favourites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings')
          ]),
    );
  }
}
