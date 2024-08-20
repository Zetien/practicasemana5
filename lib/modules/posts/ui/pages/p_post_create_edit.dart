import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_event.dart';
import 'package:proyecto_semana_5/modules/posts/data/models/post.dart';


class PostFormScreen extends StatelessWidget {
  final bool isEditing;
  final Post? post;

  PostFormScreen({super.key, required this.isEditing, this.post});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Si estamos en modo edición, prellenamos los campos con los datos del post
    if (isEditing && post != null) {
      _titleController.text = post!.title;
      _bodyController.text = post!.body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Post' : 'Crear Nuevo Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Cuerpo'),
              maxLines: 5,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              
              onPressed: () {
                final String title = _titleController.text;
                final String body = _bodyController.text;

                if (title.isNotEmpty && body.isNotEmpty) {
                  if (isEditing) {
                   
                    BlocProvider.of<PostBloc>(context).add(
                      UpdatePost(
                        post: Post(
                          id: post!.id, // Mantener el ID original
                          title: title,
                          body: body,
                          userId: post!.userId,
                        ),
                      ),
                    );
                  } else {
                   
                    BlocProvider.of<PostBloc>(context).add(
                      CreatePost(
                        post: Post(
                          id: 0, 
                          title: title,
                          body: body,
                          userId: 1, 
                        ),
                      ),
                    );
                  }

                 
                  Navigator.pop(context);
                }
              },
              child: Text(isEditing ? 'Guardar Cambios' : 'Crear Post'),
            ),
          ],
        ),
      ),
    );
  }
}
