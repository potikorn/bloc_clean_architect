import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(GetPostList());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostBloc>().state;
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount:
          state.hasReachedMax ? state.posts.length : state.posts.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        return index >= state.posts.length
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 1.5),
                ),
              )
            : _PostItem(post: state.posts[index]);
      },
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: textTheme.titleMedium,
            ),
            Text(
              post.body,
              style: textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
