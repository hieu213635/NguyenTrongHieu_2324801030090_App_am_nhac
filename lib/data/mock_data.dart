import '../models/song.dart';
import '../models/playlist.dart';

final List<Song> songs = [
  Song(
    title: 'Nơi Này Có Anh',
    artist: 'Sơn Tùng M-TP',
    albumArt: 'https://picsum.photos/300?random=1',
    duration: '4:02',
  ),
  Song(
    title: 'Lạc Trôi',
    artist: 'Sơn Tùng M-TP',
    albumArt: 'https://picsum.photos/300?random=2',
    duration: '4:33',
  ),
  Song(
    title: 'Có Chắc Yêu Là Đây',
    artist: 'Sơn Tùng M-TP',
    albumArt: 'https://picsum.photos/300?random=3',
    duration: '3:43',
  ),
  Song(
    title: 'Em Của Ngày Hôm Qua',
    artist: 'Sơn Tùng M-TP',
    albumArt: 'https://picsum.photos/300?random=4',
    duration: '3:59',
  ),
  Song(
    title: 'Bước Qua Nhau',
    artist: 'Vũ.',
    albumArt: 'https://picsum.photos/300?random=5',
    duration: '4:12',
  ),
  Song(
    title: 'Tháng Tư Là Lời Nói Dối Của Em',
    artist: 'Hà Anh Tuấn',
    albumArt: 'https://picsum.photos/300?random=6',
    duration: '5:04',
  ),
  Song(
    title: 'Có Em Chờ',
    artist: 'Min',
    albumArt: 'https://picsum.photos/300?random=7',
    duration: '3:56',
  ),
  Song(
    title: 'Đi Về Nhà',
    artist: 'Đen x JustaTee',
    albumArt: 'https://picsum.photos/300?random=8',
    duration: '3:39',
  ),
];

final List<Playlist> playlists = [
  Playlist(
    name: 'Nhạc Việt Hot',
    coverImage: 'https://picsum.photos/500?random=10',
    songs: [
      songs[0],
      songs[1],
      songs[2],
      songs[4],
    ],
  ),
  Playlist(
    name: 'Nhạc Chill',
    coverImage: 'https://picsum.photos/500?random=11',
    songs: [
      songs[4],
      songs[5],
      songs[6],
    ],
  ),
  Playlist(
    name: 'Nghe Khi Đi Đường',
    coverImage: 'https://picsum.photos/500?random=12',
    songs: [
      songs[3],
      songs[6],
      songs[7],
    ],
  ),
];