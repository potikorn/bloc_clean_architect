import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/params/post_limit_params.dart';
import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> getPosts(PostListParams params);
}
