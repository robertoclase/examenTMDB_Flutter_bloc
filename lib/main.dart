import 'package:flutter/material.dart';
import 'package:tmdb_api/features/movie_list/ui/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB App',
      home: const HomePageView(),
    );
  } 
}
