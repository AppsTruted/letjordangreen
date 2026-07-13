// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// abstract class IAudioPlayer {
//   Future<void> play(String source);
//   Future<void> pause();
//   Future<void> resume();
//   Future<void> stop();
//   Future<void> seek(Duration position);
//   Future<void> setLooping(bool loop);
// }
//
// class AssetAudioPlayer implements IAudioPlayer {
//   final AudioPlayer _player = AudioPlayer();
//   int _playCount = 0; // Track how many times the audio has played
//
//   @override
//   Future<void> play(String assetPath) async {
//     try {
//       _playCount = 0; // Reset play count before playing
//       await _player.play(AssetSource(assetPath));
//
//       // Listen for when the audio completes
//       _player.onPlayerComplete.listen((event) async {
//         if (_playCount == 0) {
//           _playCount++; // Increment play count after first play
//           await _player.play(AssetSource(assetPath)); // Play again
//         }
//       });
//     } catch (e) {
//       print("Error playing asset: $e");
//     }
//   }
//
//   @override
//   Future<void> pause() async => await _player.pause();
//
//   @override
//   Future<void> resume() async => await _player.resume();
//
//   @override
//   Future<void> stop() async => await _player.stop();
//
//   @override
//   Future<void> seek(Duration position) async => await _player.seek(position);
//
//   @override
//   Future<void> setLooping(bool loop) async {
//     await _player.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
//   }
// }
//
// class AudioManager {
//   final IAudioPlayer _audioPlayer;
//
//   AudioManager(this._audioPlayer);
//
//   Future<void> play(String source) => _audioPlayer.play(source);
//   Future<void> pause() => _audioPlayer.pause();
//   Future<void> resume() => _audioPlayer.resume();
//   Future<void> stop() => _audioPlayer.stop();
//   Future<void> seek(Duration position) => _audioPlayer.seek(position);
//   Future<void> setLooping(bool loop) => _audioPlayer.setLooping(loop);
// }
//
// class AudioPlayerScreen extends StatefulWidget {
//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }
//
// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   final audioManager = AudioManager(AssetAudioPlayer());
//   bool isLooping = true;
//
//   void toggleLooping() {
//     setState(() {
//       isLooping = !isLooping;
//     });
//     audioManager.setLooping(isLooping);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Audio Player")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => audioManager.play("audio/marimba_app_notice.mp3"),
//               child: Text("Play"),
//             ),
//             ElevatedButton(
//               onPressed: () => audioManager.pause(),
//               child: Text("Pause"),
//             ),
//             ElevatedButton(
//               onPressed: () => audioManager.stop(),
//               child: Text("Stop"),
//             ),
//             ElevatedButton(
//               onPressed: toggleLooping,
//               child: Text(isLooping ? "Disable Looping" : "Enable Looping"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
