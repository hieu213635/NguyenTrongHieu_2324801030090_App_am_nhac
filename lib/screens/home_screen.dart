import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/song.dart';
import '../widgets/music_drawer.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Song> favoriteSongs = [];

  final Color backgroundColor = const Color(0xFF0B1326);
  final Color cardColor = const Color(0xFF222A3D);
  final Color secondaryCard = const Color(0xFF131B2E);
  final Color textColor = const Color(0xFFDAE2FD);
  final Color subTextColor = const Color(0xFFCBC3D7);
  final Color purpleColor = const Color(0xFFD0BCFF);
  final Color greenColor = const Color(0xFF4EDEA3);

  Future<void> openSongDetail(Song song) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongDetailScreen(song: song)),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {
        if (!favoriteSongs.contains(song)) {
          favoriteSongs.add(song);
        }
      });
    } else if (result == false) {
      setState(() {
        favoriteSongs.remove(song);
      });
    }
  }

  void openPlaylist() {
    Navigator.pushNamed(context, '/playlist');
  }

  void openFavorite() {
    Navigator.pushNamed(context, '/favorite', arguments: favoriteSongs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const MusicDrawer(currentRoute: '/'),
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
                    _buildGreeting(),
                    _buildQuickActions(),
                    _buildTrendingBanner(),
                    _buildFilterChips(),
                    _buildSongList(),
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

  // =========================
  // HEADER
  // =========================

  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: backgroundColor.withOpacity(0.95)),
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
            'Trang Chủ',
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

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFFCBC3D7),
            ),
          ),

          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(shape: BoxShape.circle, color: cardColor),
            child: const Icon(Icons.person, size: 19, color: Color(0xFFD0BCFF)),
          ),
        ],
      ),
    );
  }

  // =========================
  // GREETING + SEARCH
  // =========================

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4EDEA3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'TRỰC TUYẾN',
                        style: TextStyle(
                          color: Color(0xFF4EDEA3),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Chào buổi tối',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.graphic_eq, color: purpleColor, size: 21),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            height: 44,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tìm bài hát, nghệ sĩ, album...',
                hintStyle: TextStyle(
                  color: const Color(0xFF958EA0),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF958EA0),
                  size: 18,
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  width: 28,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.mic_none,
                    color: Color(0xFFCBC3D7),
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // QUICK ACTION
  // =========================

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _actionCard(
              icon: Icons.queue_music,
              iconColor: purpleColor,
              title: 'Playlist',
              subtitle: '8 tuyển tập',
              onTap: openPlaylist,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: _actionCard(
              icon: Icons.favorite,
              iconColor: const Color(0xFFFF516A),
              title: 'Yêu thích',
              subtitle: '${favoriteSongs.length} bài',
              onTap: openFavorite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
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
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: subTextColor, fontSize: 11),
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: subTextColor, size: 18),
          ],
        ),
      ),
    );
  }

  // =========================
  // TRENDING
  // =========================

  Widget _buildTrendingBanner() {
    final Song featuredSong = songs.isNotEmpty
        ? songs[0]
        : Song(
            title: 'Vũ Trụ Có Anh',
            artist: 'Phương Mỹ Chi ft. Pháo',
            albumArt: 'https://picsum.photos/300',
            duration: '3:48',
          );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF211E42), Color(0xFF222A3D), Color(0xFF003B32)],
          ),
          border: Border.all(color: const Color(0xFF4EDEA3), width: 0.6),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: purpleColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '◉  Thịnh hành hôm nay',
                    style: TextStyle(
                      color: Color(0xFFE9DDFF),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D3449),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'HI-RES • 24BIT',
                    style: TextStyle(
                      color: Color(0xFF4EDEA3),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    featuredSong.albumArt,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        width: 96,
                        height: 96,
                        color: cardColor,
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vũ Trụ Có Anh',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        'Phương Mỹ Chi ft. Pháo',
                        style: TextStyle(color: subTextColor, fontSize: 13),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: const [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Color(0xFF958EA0),
                          ),
                          SizedBox(width: 3),
                          Text(
                            '3:48',
                            style: TextStyle(
                              color: Color(0xFF958EA0),
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('•', style: TextStyle(color: Color(0xFF958EA0))),
                          SizedBox(width: 8),
                          Text(
                            'Top 1 BXH',
                            style: TextStyle(
                              color: Color(0xFF4EDEA3),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    openSongDetail(featuredSong);
                  },
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Phát ngay'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    foregroundColor: const Color(0xFF3C0091),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: const StadiumBorder(),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Color(0xFFCBC3D7)),
                ),

                const Spacer(),

                const Text(
                  '↗ +1.2M lượt nghe',
                  style: TextStyle(
                    color: Color(0xFFCBC3D7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // FILTER CHIPS
  // =========================

  Widget _buildFilterChips() {
    final filters = [
      'Tất cả',
      'V-Pop',
      'Indie Việt',
      'Lossless Audio',
      'Acoustic Chill',
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: selected ? purpleColor : cardColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                filters[index],
                style: TextStyle(
                  color: selected ? const Color(0xFF3C0091) : subTextColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================
  // SONG LIST
  // =========================

  Widget _buildSongList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tất cả bài hát',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Khám phá danh sách âm nhạc phong phú',
                    style: TextStyle(color: subTextColor, fontSize: 11),
                  ),
                ],
              ),

              const Spacer(),

              const Icon(Icons.tune, size: 13, color: Color(0xFFD0BCFF)),

              const SizedBox(width: 4),

              const Text(
                'Bộ lọc',
                style: TextStyle(
                  color: Color(0xFFD0BCFF),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return _songItem(songs[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _songItem(Song song, int index) {
    final bool isFavorite = favoriteSongs.contains(song);

    return InkWell(
      onTap: () {
        openSongDetail(song);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: index == 0 ? secondaryCard : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.albumArt,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 48,
                    height: 48,
                    color: cardColor,
                    child: const Icon(
                      Icons.music_note,
                      color: Color(0xFFD0BCFF),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: index == 0 ? purpleColor : textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'LOSSLESS',
                          style: TextStyle(
                            color: Color(0xFF4EDEA3),
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: subTextColor, fontSize: 11),
                  ),
                ],
              ),
            ),

            Text(
              song.duration,
              style: TextStyle(
                color: index == 0 ? greenColor : const Color(0xFF958EA0),
                fontSize: 11,
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),

            const SizedBox(width: 4),

            IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteSongs.remove(song);
                  } else {
                    favoriteSongs.add(song);
                  }
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? const Color(0xFFFF516A)
                    : const Color(0xFF958EA0),
                size: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // MINI PLAYER + BOTTOM NAV
  // =========================

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
    final Song currentSong = songs.isNotEmpty
        ? songs[0]
        : Song(
            title: 'Nơi Này Có Anh',
            artist: 'Sơn Tùng M-TP',
            albumArt: 'https://picsum.photos/300',
            duration: '4:20',
          );

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x332E2058), blurRadius: 16)],
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentSong.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          _bottomItem(Icons.home, 'Trang chủ', true, () {}),
          _bottomItem(Icons.queue_music, 'Playlist', false, openPlaylist),
          _bottomItem(Icons.favorite_border, 'Yêu thích', false, openFavorite),
          _bottomItem(Icons.person_outline, 'Cá nhân', false, () {
            Navigator.pushNamed(context, '/profile');
          }),
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
        width: 70,
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
