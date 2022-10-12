import 'package:bloc_clean_architect/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/view/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView>
    with AutomaticKeepAliveClientMixin<PostsView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<PostBloc, PostState>(
      listener: ((context, state) {
        if (state.status == PostStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('on Error')),
          );
        }
        if (state.hasReachedMax == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No more posts')),
          );
        }
      }),
      builder: (context, state) {
        if (state.status == PostStatus.initial) {
          return const Center(
            child: Text('Initial...'),
          );
        } else if (state.status == PostStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == PostStatus.success) {
          if (state.posts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return const SafeArea(
            child: PostList(),
          );
        }
        return Container();
      },
    );
  }
}
