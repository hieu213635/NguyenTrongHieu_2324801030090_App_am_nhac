import 'package:flutter/material.dart';

import 'screens/favorite_screen.dart';
import 'screens/home_screen.dart';
import 'screens/playlist_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/recently_played_screen.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/playlist': (context) => const PlaylistScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/recently_played': (context) => const RecentlyPlayedScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
