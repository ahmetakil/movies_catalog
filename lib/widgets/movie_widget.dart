import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_catalog/model/Movie.dart';
import 'package:movies_catalog/style/styles.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;

  const MovieWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Styles.BACKGROUND_COLOR.withOpacity(0.9),
                    Styles.BACKGROUND_COLOR.withOpacity(0.1),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              child: kIsWeb
                  ? Image.network(
                      "https://image.tmdb.org/t/p/original/${movie.backPoster}",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.5,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/original/${movie.backPoster}",
                      placeholder: (_, __) =>
                          Center(child: CircularProgressIndicator()),
                      width: MediaQuery.of(context).size.width,
                      height: Styles.nowPlayingHeight(context),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 2,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "${movie.title}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
