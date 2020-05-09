import 'package:flutter/material.dart';
import 'package:movies_catalog/style/styles.dart';
import 'package:movies_catalog/widgets/genres_list.dart';
import 'package:movies_catalog/widgets/now_playing.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        appBar: AppBar(
          leading: Icon(Icons.subject),
          title: Text("Movies Catalog"),
          centerTitle: true,
          backgroundColor: Styles.BACKGROUND_COLOR,
        ),
        body: Column(
          children: [
            NowPlaying(),
            GenresList(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 32),
              height: 50,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed("movie_picker");
                },
                icon: Icon(Icons.airplay),
                label: Text("Movie Picker"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ));
  }
}
