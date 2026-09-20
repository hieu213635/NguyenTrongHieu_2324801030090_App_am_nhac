import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/song.dart';
import '../widgets/music_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Color backgroundColor = const Color(0xFF0B1326);
  final Color cardColor = const Color(0xFF222A3D);
  final Color secondaryCard = const Color(0xFF131B2E);
  final Color textColor = const Color(0xFFDAE2FD);
  final Color subTextColor = const Color(0xFFCBC3D7);
  final Color purpleColor = const Color(0xFFD0BCFF);
  final Color greenColor = const Color(0xFF4EDEA3);
  final Color pinkColor = const Color(0xFFFF516A);

  @override
  Widget build(BuildContext context) {
    final List<Song> favoriteSongs = songs.take(4).toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const MusicDrawer(currentRoute: '/profile'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(),
                    _buildStatsRow(),
                    _buildSectionTitle('Danh mục'),
                    _buildCategoryGrid(),
                    _buildSectionTitle('Cài đặt'),
                    _buildSettingsList(),
                    _buildSectionTitle('Nổi bật'),
                    _buildFavoriteList(favoriteSongs),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomArea(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            'Profile & Settings',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFFCBC3D7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFD0BCFF), Color(0xFF4EDEA3)],
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF0B1326),
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nguyễn Trọng Hiếu',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Premium Member',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'hieu.music@gmail.com',
                    style: TextStyle(color: subTextColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: secondaryCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.edit, color: Color(0xFFD0BCFF), size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'label': 'Playlist', 'value': '28'},
      {'label': 'Following', 'value': '194'},
      {'label': 'Liked', 'value': '1.2k'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: List.generate(stats.length, (index) {
          final item = stats[index];
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index == stats.length - 1 ? 0 : 8),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    item['value'] as String,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'] as String,
                    style: TextStyle(color: subTextColor, fontSize: 11),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      {
        'icon': Icons.library_music,
        'label': 'Album',
        'color': Color(0xFFD0BCFF),
      },
      {
        'icon': Icons.favorite,
        'label': 'Yêu thích',
        'color': Color(0xFFFF516A),
      },
      {'icon': Icons.download, 'label': 'Offline', 'color': Color(0xFF4EDEA3)},
      {'icon': Icons.history, 'label': 'Gần đây', 'color': Color(0xFFB7C5FF)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.7,
        ),
        itemBuilder: (context, index) {
          final item = categories[index];
          return Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsList() {
    final settings = [
      {
        'icon': Icons.account_circle_outlined,
        'label': 'Tài khoản',
        'value': 'Chỉnh sửa',
      },
      {'icon': Icons.notifications_none, 'label': 'Thông báo', 'value': 'Bật'},
      {
        'icon': Icons.dark_mode_outlined,
        'label': 'Giao diện tối',
        'value': 'Mặc định',
      },
      {'icon': Icons.security_outlined, 'label': 'Bảo mật', 'value': 'Vân tay'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(settings.length, (index) {
          final item = settings[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, color: purpleColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  item['value'] as String,
                  style: TextStyle(color: subTextColor, fontSize: 11),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: subTextColor, size: 18),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFavoriteList(List<Song> songsList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(songsList.length, (index) {
          final song = songsList[index];
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
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: secondaryCard,
                      child: const Icon(
                        Icons.music_note,
                        color: Color(0xFFD0BCFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        song.artist,
                        style: TextStyle(color: subTextColor, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_arrow, color: purpleColor, size: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomArea(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: secondaryCard.withOpacity(0.98)),
      child: SizedBox(
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
            _bottomItem(Icons.person, 'Cá nhân', true, () {}),
          ],
        ),
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
