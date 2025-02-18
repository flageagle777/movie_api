import 'package:flutter/material.dart';
import 'package:movie_api/controllers/movie_controller.dart';
import 'package:movie_api/modal.dart';
import 'package:movie_api/models/movie.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});


  @override
  State<MovieView> createState() => _MovieViewState();
}


class _MovieViewState extends State<MovieView> {
  final formKey = GlobalKey<FormState>();
  MovieController movie = MovieController();
  TextEditingController title = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController voteAverage = TextEditingController();
  List buttonChoice = ["Update", "Hapus"];
  List? film;
  int? film_id;
  getFilm() {
    setState(() {
      film = movie.movie;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFilm();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  film_id = null;
                });
                title.text = '';
                gambar.text = '';
                voteAverage.text = '';
                ModalWidget().showFullModal(context, addItem(null));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: film!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Image(image: AssetImage(film![index].posterPath)),
                title: Text(film![index].title),
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return buttonChoice.map((r) {
                      return PopupMenuItem(
                        value: r,
                        child: Text(r),
                        onTap: () {
                          if (r == "Update") {
                            setState(() {
                              film_id = film![index].id;
                            });


                            title.text = film![index].title;
                            gambar.text = film![index].posterPath;
                            voteAverage.text =
                                film![index].voteAverage.toString();
                            ModalWidget()
                                .showFullModal(context, addItem(index));
                          } else if (r == "Hapus") {
                            film!.removeWhere(
                                (item) => item.id == film![index].id);
                            getFilm();
                          }
                        },
                      );
                    }).toList();
                  },
                ),
              ),
            );
          }),
    );
  }


  Widget addItem(int? index) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
                controller: title,
                decoration: InputDecoration(label: Text("Title")),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'harus diisi';
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: gambar,
                decoration: InputDecoration(label: Text("Gambar")),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'harus diisi';
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: voteAverage,
                decoration: InputDecoration(label: Text("VoteAverage")),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'harus diisi';
                  } else {
                    return null;
                  }
                }),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (index != null) {
                      film![index].id = film_id;
                      film![index].title = title.text;
                      film![index].posterPath = gambar.text;
                      film![index].voteAverage = double.parse(voteAverage.text);
                      getFilm();
                      Navigator.pop(context);
                    } else {
                      int _id_film = film!.length + 1;
                      film!.add(MovieModel(
                        id: _id_film,
                        title: title.text,
                        posterPath: gambar.text,
                        voteAverage: double.parse(voteAverage.text),
                      ));
                      getFilm();
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text("Simpan"))
          ],
        ),
      ),
    );
  }
}
