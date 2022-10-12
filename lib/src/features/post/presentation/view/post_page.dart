import 'package:bloc_clean_architect/src/di/inject.dart';
import 'package:bloc_clean_architect/src/features/post/domain/use_cases/get_posts.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/view/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PostBloc(getIt<GetPostsUseCase>())..add(GetPostList()),
        child: const PostsView(),
      ),
    );
  }
}
