import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/ui/pages/p_post_list.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PostBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostListScreen(), // Pantalla principal de la lista de posts
    );
  }
}

