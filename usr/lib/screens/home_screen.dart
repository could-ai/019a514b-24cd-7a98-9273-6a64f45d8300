import 'package:flutter/material.dart';
import '../models/song_model.dart';
import 'lyrics_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Song> songs = [
    Song(
      title: "Nostalgia",
      artist: "Bouaré",
      lyrics: [
        LyricLine(timestamp: const Duration(seconds: 5), text: "Dans le silence de la nuit, je me perds"),
        LyricLine(timestamp: const Duration(seconds: 10), text: "Les souvenirs d'hier, un doux univers"),
        LyricLine(timestamp: const Duration(seconds: 15), text: "Ton visage en moi, une étoile qui luit"),
        LyricLine(timestamp: const Duration(seconds: 20), text: "Un amour passé, un éternel ennui"),
        LyricLine(timestamp: const Duration(seconds: 25), text: "Le temps s'enfuit, mais ton ombre reste là"),
        LyricLine(timestamp: const Duration(seconds: 30), text: "Mon cœur te cherche, où que tu sois"),
      ],
    ),
    Song(
      title: "Évasion",
      artist: "Bouaré",
      lyrics: [
        LyricLine(timestamp: const Duration(seconds: 3), text: "Loin des murs de la ville, je m'évade"),
        LyricLine(timestamp: const Duration(seconds: 8), text: "Le vent murmure une douce sérénade"),
        LyricLine(timestamp: const Duration(seconds: 12), text: "Sur les chemins de terre, mon âme nomade"),
        LyricLine(timestamp: const Duration(seconds: 18), text: "Trouve la paix, loin de la mascarade"),
        LyricLine(timestamp: const Duration(seconds: 24), text: "Le soleil se couche, le ciel est en feu"),
        LyricLine(timestamp: const Duration(seconds: 30), text: "Un instant de grâce, un monde merveilleux"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bouaré Lyrics"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text(song.artist),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LyricsScreen(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
