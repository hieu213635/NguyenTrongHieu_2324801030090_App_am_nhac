import 'package:flutter/material.dart';

class MusicDrawer extends StatelessWidget {
  final String currentRoute;

  const MusicDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Trang chủ', 'route': '/'},
      {
        'icon': Icons.queue_music_outlined,
        'label': 'Playlist',
        'route': '/playlist',
      },
      {
        'icon': Icons.favorite_border,
        'label': 'Yêu thích',
        'route': '/favorite',
      },
      {
        'icon': Icons.history,
        'label': 'Recently Played',
        'route': '/recently_played',
      },
      {
        'icon': Icons.person_outline,
        'label': 'Profile & Settings',
        'route': '/profile',
      },
    ];

    return Drawer(
      width: 300,
      backgroundColor: const Color(0xFF0B1326),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF222A3D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.graphic_eq,
                      color: Color(0xFFD0BCFF),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SoundPulse',
                    style: TextStyle(
                      color: Color(0xFFDAE2FD),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFFCBC3D7)),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ...items.map((item) {
                final selected = item['route'] == currentRoute;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFD0BCFF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: selected
                          ? const Color(0xFF0B1326)
                          : const Color(0xFFDAE2FD),
                    ),
                    title: Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: selected
                            ? const Color(0xFF0B1326)
                            : const Color(0xFFDAE2FD),
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (item['route'] != currentRoute) {
                        Navigator.pushNamed(context, item['route'] as String);
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
