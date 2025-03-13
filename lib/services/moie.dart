import 'dart:convert';
import 'package:movie_api/models/response_data_list.dart';
import 'package:movie_api/models/user_login.dart';
import 'package:movie_api/services/url.dart' as url;
import 'package:http/http.dart' as http;

class MovieService {
  Future<ResponseDataList> getMovie() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    
    if (user.status == false) {
      return ResponseDataList(
          status: false, message: 'Anda belum login / token invalid');
    }

    var uri = Uri.parse('${url.BaseUrl}/admin/getmovie');
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["status"] == true && data["data"] is List) {
          List<MovieModel> movies = (data["data"] as List)
              .map((item) => MovieModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return ResponseDataList(
              status: true, message: 'Success load data', data: movies);
        } else {
          return ResponseDataList(status: false, message: 'Failed to load data');
        }
      } else {
        return ResponseDataList(
            status: false,
            message: "Gagal load movie dengan kode error ${response.statusCode}");
      }
    } catch (e) {
      return ResponseDataList(status: false, message: 'Error: ${e.toString()}');
    }
  }
}

class MovieModel {
  // existing properties and methods

  MovieModel({
    // add required properties here
  }
  );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // parse json to create an instance of MovieModel
    return MovieModel(
      // initialize properties from json
    );
  }
}
