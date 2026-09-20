import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../widgets/music_drawer.dart';
import 'song_detail_screen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Color backgroundColor = const Color(0xFF0B1326);
  final Color cardColor = const Color(0xFF222A3D);
  final Color secondaryColor = const Color(0xFF131B2E);
  final Color textColor = const Color(0xFFDAE2FD);
  final Color subTextColor = const Color(0xFFCBC3D7);
  final Color purpleColor = const Color(0xFFD0BCFF);
  final Color greenColor = const Color(0xFF4EDEA3);

  int selectedFilter = 0;

  final List<String> filters = [
    'Tất cả',
    'Thư giãn',
    'Tập luyện',
    'Chill Vibes',
    'Top Hits',
    'Tập trung',
  ];

  final List<Map<String, dynamic>> featuredPlaylists = [
    {
      'name': 'Acoustic Buổi Sáng',
      'description': '32 bài hát • 1h 55m',
      'image': 'https://picsum.photos/500/500?random=21',
    },
    {
      'name': 'Cyberpunk & Synthwave',
      'description': '28 bài hát • 1h 48m',
      'image': 'https://picsum.photos/500/500?random=22',
    },
    {
      'name': 'Deep Focus Lofi',
      'description': '45 bài hát • 2h 40m',
      'image': 'https://picsum.photos/500/500?random=23',
    },
    {
      'name': 'Night Drive Beats',
      'description': '38 bài hát • 2h 15m',
      'image': 'https://picsum.photos/500/500?random=24',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const MusicDrawer(currentRoute: '/playlist'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 145),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    _buildFilters(),
                    _buildHighlightPlaylist(),
                    _buildFeaturedTitle(),
                    _buildFeaturedGrid(),
                    _buildMoodSection(),
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

  // ============================================================
  // HEADER
  // ============================================================

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
            child: Icon(Icons.graphic_eq, color: purpleColor, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            'Playlist',
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
            decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
            child: const Icon(Icons.person, size: 18, color: Color(0xFFD0BCFF)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bộ sưu tập Playlist',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Khám phá theo tâm trạng & phong cách sống',
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
            child: const Icon(Icons.search, color: Color(0xFFCBC3D7), size: 18),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              _showCreatePlaylistDialog();
            },
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(color: Color(0x55D0BCFF), blurRadius: 8),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.add, size: 17, color: Color(0xFF3C0091)),
                  SizedBox(width: 4),
                  Text(
                    'Tạo mới',
                    style: TextStyle(
                      color: Color(0xFF3C0091),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILTER
  // ============================================================

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool selected = selectedFilter == index;

          return InkWell(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: selected ? purpleColor : cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  filters[index],
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

  // ============================================================
  // HIGHLIGHT PLAYLIST
  // ============================================================

  Widget _buildHighlightPlaylist() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: InkWell(
        onTap: () {
          _showPlaylistSheet(
            title: 'Indie Việt Gây Nghiện',
            description: 'Vũ., Ngọt, Chillies, Trang • 42 bài hát',
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 176,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/800/500?random=30'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x99060E20),
                  Color(0xF0060E20),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'ĐƯỢC NGHE NHIỀU NHẤT',
                        style: TextStyle(
                          color: Color(0xFF003824),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xCC31394D),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'LOSSLESS',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Indie Việt Gây Nghiện',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Vũ., Ngọt, Chillies, Trang • 42 bài hát',
                            style: TextStyle(color: subTextColor, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Color(0x66D0BCFF), blurRadius: 10),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Color(0xFF3C0091),
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FEATURED TITLE
  // ============================================================

  Widget _buildFeaturedTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Text(
            'Tuyển tập đặc sắc',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            'XEM THÊM',
            style: TextStyle(
              color: greenColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FEATURED GRID
  // ============================================================

  Widget _buildFeaturedGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: featuredPlaylists.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 221,
        ),
        itemBuilder: (context, index) {
          final item = featuredPlaylists[index];

          return _playlistCard(
            name: item['name'],
            description: item['description'],
            image: item['image'],
            index: index,
          );
        },
      ),
    );
  }

  Widget _playlistCard({
    required String name,
    required String description,
    required String image,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        _showPlaylistSheet(title: name, description: description);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: cardColor,
                          child: const Center(
                            child: Icon(
                              Icons.music_note,
                              color: Color(0xFFD0BCFF),
                              size: 45,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Color(0x66000000), blurRadius: 6),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Color(0xFF3C0091),
                        size: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: subTextColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOOD SECTION
  // ============================================================

  Widget _buildMoodSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tâm trạng & Cảm xúc',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Lắng nghe bản hòa tấu theo khoảnh khắc',
                        style: TextStyle(color: subTextColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                  '4 danh sách',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 148,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _moodCard(
                  title: 'Pop Ballad Tuyển Chọn',
                  subtitle: '50 bài hát • 3h 10m',
                  tag: 'Hot V-Pop',
                  image: 'https://picsum.photos/300/300?random=41',
                  tagColor: textColor,
                ),
                _moodCard(
                  title: 'Gym & Energy Boost',
                  subtitle: '36 bài hát • 2h 05m',
                  tag: '130 - 150 BPM',
                  image: 'https://picsum.photos/300/300?random=42',
                  tagColor: greenColor,
                ),
                _moodCard(
                  title: 'Cà Phê Mưa Chiều',
                  subtitle: '29 bài hát • 1h 40m',
                  tag: 'Cozy Jazz',
                  image: 'https://picsum.photos/300/300?random=43',
                  tagColor: textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moodCard({
    required String title,
    required String subtitle,
    required String tag,
    required String image,
    required Color tagColor,
  }) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 56,
                      height: 56,
                      color: const Color(0xFF2D3449),
                      child: const Icon(
                        Icons.music_note,
                        color: Color(0xFFD0BCFF),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: subTextColor, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF31394D),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFA078FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Color(0xFF3C0091),
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM AREA
  // ============================================================

  Widget _buildBottomArea() {
    return Container(
      decoration: BoxDecoration(color: secondaryColor.withOpacity(0.98)),
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
            duration: '4:02',
          );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x332E2058), blurRadius: 16)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              currentSong.albumArt,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 40,
                  height: 40,
                  color: const Color(0xFF2D3449),
                  child: const Icon(Icons.music_note, color: Color(0xFFD0BCFF)),
                );
              },
            ),
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
          const Icon(Icons.favorite_border, color: Color(0xFFFF516A), size: 20),
          const SizedBox(width: 8),
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
          _bottomItem(Icons.home_outlined, 'Trang chủ', false, () {
            Navigator.pushNamed(context, '/');
          }),
          _bottomItem(Icons.queue_music, 'Playlist', true, () {}),
          _bottomItem(Icons.favorite_border, 'Yêu thích', false, () {
            Navigator.pushNamed(context, '/favorite');
          }),
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
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 70,
        height: 58,
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

  // ============================================================
  // PLAYLIST BOTTOM SHEET
  // ============================================================

  void _showPlaylistSheet({
    required String title,
    required String description,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: secondaryColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.72,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return _playlistSheetContent(
              title: title,
              description: description,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  Widget _playlistSheetContent({
    required String title,
    required String description,
    required ScrollController scrollController,
  }) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0x66958EA0),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFCBC3D7),
                ),
              ),
              const Spacer(),
              Text(
                'Chi tiết Playlist',
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 36),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Row(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3449),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.queue_music,
                  color: Color(0xFFD0BCFF),
                  size: 42,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: subTextColor, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '35 bài hát • 2h 10m',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (songs.isNotEmpty) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SongDetailScreen(song: songs[0]),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Phát tất cả'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    foregroundColor: const Color(0xFF3C0091),
                    elevation: 0,
                    minimumSize: const Size(0, 48),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _sheetCircleButton(Icons.shuffle),
              const SizedBox(width: 8),
              _sheetCircleButton(Icons.more_vert),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return _sheetSongItem(songs[index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _sheetCircleButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
      child: Icon(icon, color: subTextColor, size: 20),
    );
  }

  Widget _sheetSongItem(Song song, int index) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SongDetailScreen(song: song)),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: index == 0 ? const Color(0xFF2D3449) : const Color(0x66222A3D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF31394D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.music_note,
                color: Color(0xFFD0BCFF),
                size: 19,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: index == 0 ? purpleColor : textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${song.artist} • LOSSLESS',
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
                color: subTextColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.play_circle_outline,
              color: Color(0xFFCBC3D7),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CREATE PLAYLIST
  // ============================================================

  void _showCreatePlaylistDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          title: Text('Tạo Playlist mới', style: TextStyle(color: textColor)),
          content: TextField(
            controller: controller,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: 'Tên playlist',
              hintStyle: TextStyle(color: subTextColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFF3A4153)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: purpleColor),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy', style: TextStyle(color: subTextColor)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Đã tạo Playlist mới')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: purpleColor,
                foregroundColor: const Color(0xFF3C0091),
              ),
              child: const Text('Tạo'),
            ),
          ],
        );
      },
    );
  }
}
