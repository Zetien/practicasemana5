import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_bloc.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_event.dart';
import 'package:proyecto_semana_5/modules/posts/controllers/bloc/c_post_state.dart';
import 'package:proyecto_semana_5/modules/posts/ui/pages/p_post_create_edit.dart';
import 'package:proyecto_semana_5/modules/posts/ui/pages/widgets/w_custom_text.dart';
import 'package:proyecto_semana_5/theme/theme_colors.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PostBloc()..add(GetPosts()),
        child: Scaffold(
         appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
            title: Center(
              child: CustomText(
                text: 'POST JSON Placeholder by Zetien',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
         
        ),
          body: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostLoaded) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Card(
                      elevation: 4,
                      surfaceTintColor: ThemeColors.white,
                      color: ThemeColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(
                          color: ThemeColors.primary,
                        ),
                      ),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: ThemeColors.primary),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: BlocProvider.of<PostBloc>(context),
                                      child: PostFormScreen(
                                          isEditing: true, post: post),
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: ThemeColors.danger),
                              onPressed: () {
                                BlocProvider.of<PostBloc>(context)
                                    .add(DeletePost(postId: post.id));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is PostError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('No Posts Found'));
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ThemeColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<PostBloc>(
                        context), // Reutilizar el mismo BLoC
                    child: PostFormScreen(isEditing: false),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add, color: ThemeColors.white,),
          ),
        ));
  }
}
