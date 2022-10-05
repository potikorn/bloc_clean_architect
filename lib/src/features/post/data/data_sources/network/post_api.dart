import 'package:bloc_clean_architect/src/core/data/network/dio_client.dart';
import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/params/post_limit_params.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IPostApi {
  Future<Response> getPosts(PostListParams params);
}

@Injectable(as: IPostApi)
class PostApi extends IPostApi {
  final DioClient _dioClient;

  PostApi(this._dioClient);

  @override
  Future<Response> getPosts(PostListParams params) async {
    try {
      final Response res = await _dioClient.get(
        EndPoints.posts,
        queryParameters: params.toMap(),
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
