import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/models/audio_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:musicapp/providers/favourites_provider.dart';
import 'package:musicapp/providers/favouriteshandler.dart';
import 'package:musicapp/screens/download.dart';

import 'package:permission_handler/permission_handler.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({
    super.key,
    required this.playlist,
    required this.id,
    required this.objectId,
  });

  final List<Audio> playlist;
  final dynamic id;
  final String objectId;

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen> {
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  late int _currentIndex;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.id;
    _audioPlayer = AudioPlayer();
    _isPlaying = false;
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() => _duration = duration);
      }
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() => _position = position);
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        onPlayerComplete();
      }
    });
    _isFavourite(widget.playlist[_currentIndex].id);
  }

  Future<void> requestPermissions() async {
  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }

  if (!await Permission.systemAlertWindow.isGranted) {
    await Permission.systemAlertWindow.request();
  }

  if (!await Permission.accessMediaLocation.isGranted) {
    await Permission.accessMediaLocation.request();
  }
}
  
  void onPlayerComplete() {
    setState(() {
      _position = Duration.zero;
      _isPlaying = false;
    });
  }

  String _buildAudioUrl(String rawPath) {
    final sanitizedPath = rawPath.replaceAll(r'\', '/');
    return 'http://192.168.147.201:8080/$sanitizedPath';
  }



  Future<String?> fetchSingleAudio(String id) async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.147.201:8080/audio/single-audio/$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final path = data['audio']['audioUrl'];

        return _buildAudioUrl(path);
      }
    } catch (e) {
      print('Error fetching audio: $e');
    }
    return null;
  }



  Future<void> _playAudio(String id) async {
    try {
      final url = await fetchSingleAudio(id);
      setState(() => _isPlaying = true);
      if (url == null) return;
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print("Audio play error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to play audio')),
      );
    }
  }

  bool isFavourite = true;

  void _favouriteHandler(String id) async {
    final result = await FavouriteManager.isFavourite(id);
    if (result) {
      await FavouriteManager.removeFromFavourites(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from Favourites')),
      );
    } else {
      await FavouriteManager.addToFavourites(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to Favourites')),
      );
    }

    // Update the state
    _isFavourite(id);
  }

  void _isFavourite(String id) async {
    final result = await FavouriteManager.isFavourite(id);
    setState(() {
      isFavourite = result;
    });
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() => _isPlaying = false);
  }

  void _nextAudio() async {
    if (_currentIndex < widget.playlist.length - 1) {
      setState(() => _currentIndex++);
      await _carouselController.nextPage();
      await _playAudio(widget.playlist[_currentIndex].id);
    }
  }

  void _previousAudio() async {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      await _carouselController.previousPage();
      await _playAudio(widget.playlist[_currentIndex].id);
    }
  }

  String _formatTime(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = position.inMinutes.remainder(60);
    final seconds = position.inSeconds.remainder(60);
    final hours = twoDigits(position.inHours);
    return [
      if (position.inHours > 0) hours,
      twoDigits(minutes),
      twoDigits(seconds)
    ].join(':');  
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void fileDownloader(){
    

  }

  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    // final favouriteAudios = ref.watch(favouriteAudioProvider);
    // final favNotifier = ref.read(favouriteAudioProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border,
            color: isFavourite ? Colors.red : Colors.grey,
            size: 30,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.playlist.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Song ${index + 1}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                initialPage: widget.id,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) async {
                  setState(() => _currentIndex = index);
                  await _playAudio(widget.playlist[_currentIndex].id);
                  _isFavourite(
                      widget.playlist[_currentIndex].id); // 👈 update fav icon
                },
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  widget.playlist[_currentIndex].title,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  widget.playlist[_currentIndex].profile,
                  style: const TextStyle(color: Colors.white),
                ),
                Slider(
                  activeColor: Colors.green,
                  inactiveColor: Colors.white,
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds
                      .toDouble()
                      .clamp(0, _duration.inSeconds.toDouble()),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(position);
                    await _audioPlayer.play();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatTime(_position),
                          style: const TextStyle(color: Colors.white)),
                      Text(_formatTime(_duration),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await downloadAndSetAudio(
  context: context,
  downloadUrl: 'https://your-api.com/audio/notify.mp3',
  filename: 'notify.mp3',
  type: AudioType.notification,
);
                  },
                  icon: const Icon(Icons.download_outlined),
                  iconSize: 30,
                  color: Colors.white54,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _previousAudio,
                      icon: const Icon(Icons.skip_previous_rounded),
                      iconSize: 30,
                      color: Colors.white54,
                    ),
                    IconButton(
                      onPressed: _isPlaying
                          ? _pauseAudio
                          : () => _playAudio(widget.playlist[_currentIndex].id),
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle_fill_outlined,
                      ),
                      iconSize: 75,
                      color: Colors.green,
                    ),
                    IconButton(
                      onPressed: _nextAudio,
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 30,
                      color: Colors.white54,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    final id = widget.playlist[_currentIndex].id;
                    _favouriteHandler(id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
