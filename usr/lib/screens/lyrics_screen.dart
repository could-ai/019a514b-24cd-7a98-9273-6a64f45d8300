import 'dart:async';
import 'package:flutter/material.dart';
import '../models/song_model.dart';

class LyricsScreen extends StatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  Timer? _timer;
  Duration _currentPosition = Duration.zero;
  int _currentLyricIndex = -1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startPlayback();
  }

  void _startPlayback() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentPosition += const Duration(milliseconds: 100);
        _updateCurrentLyric();
      });
    });
  }

  void _updateCurrentLyric() {
    for (var i = 0; i < widget.song.lyrics.length; i++) {
      if (_currentPosition >= widget.song.lyrics[i].timestamp) {
        if (i == widget.song.lyrics.length - 1 || _currentPosition < widget.song.lyrics[i + 1].timestamp) {
          if (_currentLyricIndex != i) {
            setState(() {
              _currentLyricIndex = i;
              // Scroll to the current lyric
              _scrollToCurrentLyric(i);
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToCurrentLyric(int index) {
    // Assuming each item has a fixed height of around 60.0
    double offset = index * 60.0;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.song.lyrics.length,
          itemBuilder: (context, index) {
            final lyricLine = widget.song.lyrics[index];
            final isCurrentLine = index == _currentLyricIndex;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text(
                lyricLine.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.normal,
                  color: isCurrentLine ? Theme.of(context).colorScheme.primary : Colors.black87,
                  height: 1.5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
