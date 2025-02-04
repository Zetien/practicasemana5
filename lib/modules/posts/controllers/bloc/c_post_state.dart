import 'package:equatable/equatable.dart';
import 'package:proyecto_semana_5/modules/posts/data/models/post.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}
