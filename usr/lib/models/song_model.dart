class LyricLine {
  final Duration timestamp;
  final String text;

  LyricLine({required this.timestamp, required this.text});
}

class Song {
  final String title;
  final String artist;
  final List<LyricLine> lyrics;

  Song({required this.title, required this.artist, required this.lyrics});
}
