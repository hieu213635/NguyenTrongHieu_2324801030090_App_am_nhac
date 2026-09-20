import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/song.dart';
import '../widgets/music_drawer.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Color backgroundColor = const Color(0xFF0B1326);
  final Color cardColor = const Color(0xFF222A3D);
  final Color secondaryCard = const Color(0xFF131B2E);
  final Color textColor = const Color(0xFFDAE2FD);
  final Color subTextColor = const Color(0xFFCBC3D7);
  final Color purpleColor = const Color(0xFFD0BCFF);
  final Color greenColor = const Color(0xFF4EDEA3);
  final Color pinkColor = const Color(0xFFFF516A);

  List<Song> recentSongs = [];
  int selectedCategory = 0;

  final List<String> categories = [
    'Tất cả',
    'V-Pop',
    'US-UK',
    'EDM',
    'Chill',
    'Podcast',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is List<Song>) {
      recentSongs = List<Song>.from(args);
    } else {
      recentSongs = List<Song>.from(songs.take(6));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const MusicDrawer(currentRoute: '/recently_played'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    _buildCategoryChips(),
                    _buildSummaryCard(),
                    _buildRecentList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomArea(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: backgroundColor.withOpacity(0.96)),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu, color: Color(0xFFCBC3D7)),
            tooltip: 'Menu',
          ),
          const SizedBox(width: 4),
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
          const SizedBox(width: 8),
          Text(
            'Recently Played',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFFCBC3D7)),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
            child: const Icon(Icons.person, size: 18, color: Color(0xFFD0BCFF)),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: pinkColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.history,
              color: Color(0xFFFF516A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gần đây',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Các bài hát bạn vừa nghe',
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${recentSongs.length} bài',
            style: TextStyle(
              color: purpleColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;
          return InkWell(
            onTap: () => setState(() => selectedCategory = index),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? purpleColor : cardColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: selected ? const Color(0xFF3C0091) : subTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.play_circle_fill,
              color: Color(0xFF4EDEA3),
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lượt nghe hôm nay',
                  style: TextStyle(color: subTextColor, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  '1h 26m • 18 bài hát',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: List.generate(recentSongs.length, (index) {
          final song = recentSongs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    song.albumArt,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 52,
                      height: 52,
                      color: secondaryCard,
                      child: const Icon(
                        Icons.music_note,
                        color: Color(0xFFD0BCFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        song.artist,
                        style: TextStyle(color: subTextColor, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  song.duration,
                  style: TextStyle(color: subTextColor, fontSize: 11),
                ),
                const SizedBox(width: 8),
                Icon(Icons.more_vert, color: subTextColor, size: 18),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomArea() {
    return Container(
      decoration: BoxDecoration(color: secondaryCard.withOpacity(0.98)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildMiniPlayer(), _buildBottomNavigation()],
      ),
    );
  }

  Widget _buildMiniPlayer() {
    final Song currentSong = recentSongs.isNotEmpty
        ? recentSongs.first
        : songs.first;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2D3449),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Color(0xFFD0BCFF)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSong.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentSong.artist,
                  style: TextStyle(color: subTextColor, fontSize: 10),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Color(0xFFFF516A),
              size: 20,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: purpleColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Color(0xFF3C0091)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            Icons.home_outlined,
            'Trang chủ',
            false,
            () => Navigator.pushNamed(context, '/'),
          ),
          _bottomItem(
            Icons.queue_music_outlined,
            'Playlist',
            false,
            () => Navigator.pushNamed(context, '/playlist'),
          ),
          _bottomItem(
            Icons.favorite_border,
            'Yêu thích',
            false,
            () => Navigator.pushNamed(context, '/favorite'),
          ),
          _bottomItem(
            Icons.person_outline,
            'Cá nhân',
            false,
            () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem(
    IconData icon,
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19, color: selected ? purpleColor : subTextColor),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: selected ? purpleColor : subTextColor,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
