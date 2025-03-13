import 'package:flutter/material.dart';
import 'package:movie_api/views/dashboard.dart';
import 'package:movie_api/views/login_view.dart';
import 'package:movie_api/views/movie_view.dart';
import 'package:movie_api/views/register_user_view.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RegisterUserView(),
      '/login': (context) => LoginView(),
      '/dashboard':(context) => DashboardView(),
      '/movie': (context) => MovieView(),
    },
  ));
}


