import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> getPosts();
}
