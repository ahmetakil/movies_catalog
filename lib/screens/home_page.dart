import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_catalog/style/styles.dart';
import 'package:movies_catalog/widgets/genres_list.dart';
import 'package:movies_catalog/widgets/now_playing.dart';

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 32),
              height: 50,
              child: RaisedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (ctx) {
                        final _passwordController = TextEditingController();
                        return AlertDialog(
                          title: Text("Login"),
                          content: Container(
                            height: 200,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelText: "Password",
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    RaisedButton(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      onPressed: () async {
                                        final password =
                                            _passwordController.text;
                                        try {
                                          final result = await Firestore
                                              .instance
                                              .collection("users")
                                              .document("$password")
                                              .get();

                                          if (result.data == null) {
                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text("Invalid Password"),
                                              duration: Duration(seconds: 1),
                                            ));
                                            return;
                                          }
                                          final name = result.data["name"];
                                          Navigator.of(context).pushNamed(
                                              "movie_picker",
                                              arguments: {
                                                'name': name,
                                                'password': password
                                              });
                                          print("name is $name");
                                        } catch (e) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text("Invalid Password"),
                                            duration: Duration(seconds: 1),
                                          ));
                                          return;
                                        }
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
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
