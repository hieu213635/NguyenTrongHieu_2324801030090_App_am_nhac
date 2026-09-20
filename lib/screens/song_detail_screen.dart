import 'package:flutter/material.dart';

import '../models/song.dart';

class SongDetailScreen extends StatefulWidget {
  final Song song;

  const SongDetailScreen({
    super.key,
    required this.song,
  });

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  bool isFavorite = false;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final song = widget.song;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1326),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1326),
        foregroundColor: const Color(0xFFDAE2FD),
        elevation: 0,
        title: const Text(
          'Chi tiết bài hát',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, isFavorite);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            children: [
              _buildAlbumArt(song),
              const SizedBox(height: 28),
              _buildSongInfo(song),
              const SizedBox(height: 24),
              _buildProgress(),
              const SizedBox(height: 8),
              _buildTime(song),
              const SizedBox(height: 20),
              _buildControls(),
              const SizedBox(height: 28),
              _buildActionButtons(),
              const SizedBox(height: 28),
              _buildQualityCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumArt(Song song) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 340,
        maxHeight: 340,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x552E2058),
            blurRadius: 30,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            song.albumArt,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                color: const Color(0xFF222A3D),
                child: const Icon(
                  Icons.music_note,
                  color: Color(0xFFD0BCFF),
                  size: 90,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo(Song song) {
    return Column(
      children: [
        Text(
          song.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFFDAE2FD),
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          song.artist,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFCBC3D7),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4EDEA3).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'LOSSLESS AUDIO',
            style: TextStyle(
              color: Color(0xFF4EDEA3),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFFD0BCFF),
            inactiveTrackColor: const Color(0xFF3A4153),
            thumbColor: const Color(0xFFD0BCFF),
            overlayColor: const Color(0x33D0BCFF),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
            ),
          ),
          child: Slider(
            value: isPlaying ? 0.35 : 0.0,
            min: 0,
            max: 1,
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }

  Widget _buildTime(Song song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '0:00',
          style: TextStyle(
            color: Color(0xFF958EA0),
            fontSize: 11,
          ),
        ),
        Text(
          song.duration,
          style: const TextStyle(
            color: Color(0xFF958EA0),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shuffle,
            color: Color(0xFFCBC3D7),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.skip_previous_rounded,
            color: Color(0xFFDAE2FD),
            size: 34,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              isPlaying = !isPlaying;
            });
          },
          child: Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFD0BCFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: Color(0xFF3C0091),
              size: 34,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.skip_next_rounded,
            color: Color(0xFFDAE2FD),
            size: 34,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.repeat,
            color: Color(0xFFCBC3D7),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _actionButton(
          icon: isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          label: 'Yêu thích',
          color: isFavorite
              ? const Color(0xFFFF516A)
              : const Color(0xFFCBC3D7),
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
        const SizedBox(width: 14),
        _actionButton(
          icon: Icons.playlist_add,
          label: 'Playlist',
          color: const Color(0xFFD0BCFF),
          onTap: () {},
        ),
        const SizedBox(width: 14),
        _actionButton(
          icon: Icons.share_outlined,
          label: 'Chia sẻ',
          color: const Color(0xFFCBC3D7),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 92,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF222A3D),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 21,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFCBC3D7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF2C354A),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.graphic_eq,
            color: Color(0xFF4EDEA3),
            size: 22,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chất lượng âm thanh cao',
                  style: TextStyle(
                    color: Color(0xFFDAE2FD),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Âm thanh Lossless • 24-bit',
                  style: TextStyle(
                    color: Color(0xFF958EA0),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: Color(0xFF4EDEA3),
            size: 19,
          ),
        ],
      ),
    );
  }
}