import 'package:CurrentMovies/src/models/movies_videos.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewYoutubeVideo extends StatefulWidget {
  const ViewYoutubeVideo({super.key, required this.movie});
  final MovieVideo movie;

  @override
  State<ViewYoutubeVideo> createState() => _ViewYoutubeVideoState();
}

class _ViewYoutubeVideoState extends State<ViewYoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = YoutubePlayerController(
      initialVideoId: this.widget.movie.key,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    this._controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.share,
                ),
                onPressed: () {
                  Share.share(this.widget.movie.getUrlVideo());
                },
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          YoutubePlayer(
            controller: this._controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColors.$colorYoutubeView,
            progressColors: const ProgressBarColors(
              playedColor: AppColors.$colorYoutubeView,
              handleColor: AppColors.$colorYoutubeView,
            ),
          ),
        ],
      ),
    );
  }
}
