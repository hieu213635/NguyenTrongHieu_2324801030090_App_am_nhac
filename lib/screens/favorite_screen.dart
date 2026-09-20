import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/song.dart';
import '../widgets/music_drawer.dart';
import 'song_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Color backgroundColor = const Color(0xFF0B1326);
  final Color cardColor = const Color(0xFF222A3D);
  final Color darkCardColor = const Color(0xFF131B2E);
  final Color textColor = const Color(0xFFDAE2FD);
  final Color subTextColor = const Color(0xFFCBC3D7);
  final Color purpleColor = const Color(0xFFD0BCFF);
  final Color greenColor = const Color(0xFF4EDEA3);
  final Color pinkColor = const Color(0xFFFF516A);

  late List<Song> favoriteSongs;

  int selectedSort = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is List<Song>) {
      favoriteSongs = List<Song>.from(args);
    } else {
      favoriteSongs = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const MusicDrawer(currentRoute: '/favorite'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 145),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    _buildActionDeck(),
                    _buildSummaryCard(),
                    _buildSortFilters(),
                    _buildFavoriteList(),
                    _buildEmptyStatePreview(),
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
      decoration: BoxDecoration(color: backgroundColor.withOpacity(0.92)),
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
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.graphic_eq, color: purpleColor, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            'Yêu Thích',
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // 👈 đổi từ .start
      children: [
        Container(
          width: 39,
          height: 40,
          alignment: Alignment.center, // 👈 thêm dòng này
          decoration: BoxDecoration(
            color: pinkColor,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x4DFF516A),
                blurRadius: 14,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: const Icon(Icons.favorite, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment
                .center, // 👈 thêm để chữ căn giữa theo chiều dọc so với icon
            children: [
              Text(
                'Bài hát yêu thích',
                style: TextStyle(
                  color: textColor,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  height: 1.0, // 👈 giúp bỏ khoảng đệm trên/dưới của font, tránh lệch baseline
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 39,
          height: 40,
          alignment: Alignment.center, // 👈 thêm dòng này
          decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
          child: const Icon(
            Icons.more_vert,
            color: Color(0xFFCBC3D7),
            size: 19,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PLAY / SHUFFLE
  // ============================================================

  Widget _buildActionDeck() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (favoriteSongs.isNotEmpty) {
                  _openSong(favoriteSongs.first);
                }
              },
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x59D0BCFF),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shuffle, color: Color(0xFF3C0091), size: 17),
                    SizedBox(width: 8),
                    Text(
                      'Phát ngẫu nhiên',
                      style: TextStyle(
                        color: Color(0xFF3C0091),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              if (favoriteSongs.isNotEmpty) {
                _openSong(favoriteSongs.first);
              }
            },
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Color(0xFFD0BCFF)),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUMMARY CARD
  // ============================================================

  Widget _buildSummaryCard() {
    final int count = favoriteSongs.length;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkCardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25,
            bottom: -25,
            child: Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: purpleColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: greenColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'ĐỒNG BỘ VỚI HOME STATE',
                              style: TextStyle(
                                color: greenColor,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$count bài hát yêu thích',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          count > 0
                              ? 'Tổng thời lượng: ${_calculateTotalDuration()} • Cập nhật hôm nay'
                              : 'Tổng thời lượng: 0 phút • Cập nhật hôm nay',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3449),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sync, color: purpleColor, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'Synced',
                          style: TextStyle(
                            color: purpleColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_done_outlined,
                      color: greenColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Nghe không cần mạng mọi lúc',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textColor, fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Tải ngoại tuyến',
                        style: TextStyle(
                          color: Color(0xFF003824),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SORT FILTER
  // ============================================================

  Widget _buildSortFilters() {
    final filters = ['Mới thêm', 'Tên bài A-Z', 'Nghệ sĩ'];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 12),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              children: [
                const Icon(Icons.sort, color: Color(0xFFCBC3D7), size: 13),
                const SizedBox(width: 4),
                Text(
                  'Sắp xếp:',
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }

          final filterIndex = index - 1;
          final selected = selectedSort == filterIndex;

          return InkWell(
            onTap: () {
              setState(() {
                selectedSort = filterIndex;
              });
            },
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: selected ? purpleColor : cardColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  Text(
                    filters[filterIndex],
                    style: TextStyle(
                      color: selected ? const Color(0xFF3C0091) : subTextColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (selected) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF3C0091),
                      size: 13,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FAVORITE LIST
  // ============================================================

  Widget _buildFavoriteList() {
    if (favoriteSongs.isEmpty) {
      return const SizedBox.shrink();
    }

    List<Song> sortedSongs = List<Song>.from(favoriteSongs);

    if (selectedSort == 1) {
      sortedSongs.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == 2) {
      sortedSongs.sort((a, b) => a.artist.compareTo(b.artist));
    }

    return Column(
      children: List.generate(sortedSongs.length, (index) {
        return _songRow(sortedSongs[index], index);
      }),
    );
  }

  Widget _songRow(Song song, int index) {
    return InkWell(
      onTap: () {
        _openSong(song);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 68,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: index == 0 ? const Color(0x99171F33) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Text(
                '${index + 1}'.padLeft(2, '0'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == 0 ? purpleColor : const Color(0xFF494454),
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Album image
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
                      size: 20,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 8),

            // Song information
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (index == 0)
                        _qualityTag('LOSSLESS', greenColor)
                      else if (index == 2)
                        _qualityTag('HQ', subTextColor)
                      else if (index == 3)
                        _qualityTag('EXPLICIT', const Color(0xFFFFB2B7)),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: subTextColor, fontSize: 10),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    _addedTime(index),
                    style: const TextStyle(
                      color: Color(0xFF958EA0),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite
            IconButton(
              onPressed: () {
                setState(() {
                  favoriteSongs.remove(song);
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              icon: const Icon(
                Icons.favorite,
                color: Color(0xFFFF516A),
                size: 18,
              ),
            ),

            // More
            const SizedBox(
              width: 24,
              child: Icon(Icons.more_vert, color: Color(0xFFCBC3D7), size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qualityTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _addedTime(int index) {
    switch (index) {
      case 0:
        return 'Thêm 2 giờ trước';
      case 1:
        return 'Thêm hôm qua';
      case 2:
        return 'Thêm 3 ngày trước';
      case 3:
        return 'Thêm 5 ngày trước';
      default:
        return 'Thêm 1 tuần trước';
    }
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyStatePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF060E20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.list_alt_outlined,
                color: Color(0xFF958EA0),
                size: 14,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'PREVIEW TRẠNG THÁI DANH SÁCH RỖNG\n(LOGIC UI)',
                  style: TextStyle(
                    color: const Color(0xFF958EA0),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                'Ẩn /\nHiện',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: purpleColor,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xB3131B2E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D3449),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Color(0xFF777286),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Chưa có bài hát yêu thích nào',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hãy bấm biểu tượng trái tim ❤️ ở trang chủ hoặc\n'
                  'trình phát để thêm bài hát vào đây!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 10,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Khám phá bài hát ngay',
                      style: TextStyle(
                        color: purpleColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
      decoration: BoxDecoration(color: darkCardColor.withOpacity(0.97)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildMiniPlayer(), _buildBottomNavigation()],
      ),
    );
  }

  Widget _buildMiniPlayer() {
    final Song currentSong = favoriteSongs.isNotEmpty
        ? favoriteSongs.first
        : songs[0];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x552E2058), blurRadius: 16)],
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
                  child: const Icon(
                    Icons.music_note,
                    color: Color(0xFFD0BCFF),
                    size: 18,
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
                  currentSong.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentSong.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: subTextColor, fontSize: 9),
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: Color(0xFFFF516A), size: 19),
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
          _bottomItem(Icons.queue_music, 'Playlist', false, () {
            Navigator.pushNamed(context, '/playlist');
          }),
          _bottomItem(Icons.favorite, 'Yêu thích', true, () {}),
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
  // HELPERS
  // ============================================================

  void _openSong(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SongDetailScreen(song: song)),
    );
  }

  String _calculateTotalDuration() {
    int totalSeconds = 0;

    for (final song in favoriteSongs) {
      final parts = song.duration.split(':');

      if (parts.length == 2) {
        final minutes = int.tryParse(parts[0]) ?? 0;
        final seconds = int.tryParse(parts[1]) ?? 0;

        totalSeconds += minutes * 60 + seconds;
      }
    }

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;

    if (hours > 0) {
      return '$hours giờ $minutes phút';
    }

    return '$minutes phút';
  }
}
