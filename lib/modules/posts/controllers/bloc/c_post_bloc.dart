import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_event.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_state.dart';
import 'package:proyecto_semana_5/modules/posts/data/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostBloc extends Bloc<PostEvent, PostState> {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  PostBloc() : super(PostInitial()) {
    on<GetPosts>(_onGetPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  
  Future<void> _onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Post> posts = jsonResponse.map((post) => Post.fromJson(post)).toList();
        emit(PostLoaded(posts: posts));
      } else {
        emit(PostError(message: "Error al cargar los posts"));
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  
  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(event.post.toJson()),
      );

      if (response.statusCode == 201) {
        final newPost = Post.fromJson(json.decode(response.body));
        log('Nuevo post creado: $newPost');
        final currentState = state;
        if (currentState is PostLoaded) {
          final updatedPosts = List<Post>.from(currentState.posts)..insert(0, newPost);
          emit(PostLoaded(posts: updatedPosts));
        }
      } else {
        emit(PostError(message: "Error al crear el post"));
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

 
  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${event.post.id}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(event.post.toJson()),
      );

      if (response.statusCode == 200) {
        final updatedPost = Post.fromJson(json.decode(response.body));
         log('Post Actualizado: $updatedPost');
        final currentState = state;
        if (currentState is PostLoaded) {
          final updatedPosts = currentState.posts.map((post) {
            return post.id == updatedPost.id ? updatedPost : post;
          }).toList();
          emit(PostLoaded(posts: updatedPosts));
        }
      } else {
        emit(PostError(message: "Error al actualizar el post"));
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

 
  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/${event.postId}'));

      if (response.statusCode == 200) {
        final currentState = state;
        if (currentState is PostLoaded) {
          final updatedPosts = currentState.posts.where((post) => post.id != event.postId).toList();
          emit(PostLoaded(posts: updatedPosts));
        }
      } else {
        emit(PostError(message: "Error al eliminar el post"));
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
