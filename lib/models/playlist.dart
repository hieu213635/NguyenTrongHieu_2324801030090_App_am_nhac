import 'song.dart';

class Playlist {
  final String name;
  final String coverImage;
  final List<Song> songs;

  Playlist({required this.name, required this.coverImage, required this.songs});
}
