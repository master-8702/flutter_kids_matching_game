import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This class is responsible for playing audio files.
/// It uses the audioplayers package to play audio files from the assets.
/// It provides methods to play different sounds for success, error, win, and lose.
class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String assetPath) async {
    await _audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> playSuccess() => playSound('sounds/success_bell2.mp3');

  Future<void> playError() => playSound('sounds/error.mp3');

  Future<void> playWin() => playSound('sounds/win.mp3');

  Future<void> playLose() => playSound('sounds/lose.mp3');
}

final audioServiceProvider = Provider<AudioService>((ref) => AudioService());
