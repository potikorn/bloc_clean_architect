import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  const PostList({super.key, required this.postListModel});

  final List<PostModel> postListModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: postListModel.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        final post = postListModel[index];
        return _PostItem(post: post);
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
