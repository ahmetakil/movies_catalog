import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_catalog/style/styles.dart';

class MoviePicker extends StatefulWidget {
  @override
  _MoviePickerState createState() => _MoviePickerState();
}

class _MoviePickerState extends State<MoviePicker> {
  final _movieController = TextEditingController();
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name;
  String password;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    name = args["name"];
    password = args["password"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Styles.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Styles.BACKGROUND_COLOR,
        title: Text("Movie Picker - ${name}"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildInputHeader(),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                Firestore.instance.collection("movies").limit(10).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> movieList = snapshot.data.documents;
              return Expanded(
                child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return movieTile(movieList[i]);
                    },
                    itemCount: movieList.length),
              );
            },
          )
        ],
      ),
    );
  }

  Widget movieTile(movieData) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          "0",
          style: TextStyle(color: Colors.white),
        ),
      ),
      subtitle: Text(
        "Suggested by ${movieData["name"]}",
        style: TextStyle(color: Colors.grey),
      ),
      title: RichText(
        text: TextSpan(
          text: "Movie: ",
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
                text: movieData["movie"],
                style: TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildInputHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 80,
            child: TextField(
              controller: _movieController,
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 1,
              maxLength: 30,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Movie",
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 2,
          child: _loading
              ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : FlatButton.icon(
                  label: Text(
                    "ADD",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onPressed: () async {
                    try {
                      if (!isInputValid(_movieController.text)) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Invalid Input !"),
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }
                      setState(() {
                        _loading = true;
                      });
                      final DocumentReference result = await Firestore.instance
                          .collection("movies")
                          .add({'name': name, 'movie': _movieController.text});
                      setState(() {
                        _loading = false;
                      });
                      _movieController.clear();
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
        ),
      ],
    );
  }

  bool isInputValid(String movie) {
    if (movie.isEmpty) {
      print("returned false");
      return false;
    }
    print("returned true");
    return true;
  }
}
