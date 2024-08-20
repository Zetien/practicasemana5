import 'package:equatable/equatable.dart';
import 'package:proyecto_semana_5/modules/posts/data/models/post.dart';


abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final int postId;

  const DeletePost({required this.postId});

  @override
  List<Object> get props => [postId];
}
