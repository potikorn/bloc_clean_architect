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
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<PostBloc, PostState>(
      listener: ((context, state) {
        if (state is PostError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? '')),
          );
        }
      }),
      builder: (context, state) {
        if (state is PostInitial) {
          return const Center(
            child: Text('Initial...'),
          );
        } else if (state is PostLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostSuccess) {
          return SafeArea(
            child: PostList(postListModel: state.postListModel),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
