import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/post_api.dart';
import 'package:bloc_clean_architect/src/features/post/data/entities/post_entity.dart';
import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IPostRepository)
class PostRepository extends IPostRepository {
  final IPostApi _postApi;

  PostRepository(this._postApi);

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _postApi.getPosts();
      final posts =
          (response.data as List).map((e) => PostEntity.fromJson(e)).toList();
      return posts;
    } on DioError catch (_) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      rethrow;
    }
  }
}
