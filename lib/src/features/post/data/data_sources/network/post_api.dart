import 'package:bloc_clean_architect/src/core/data/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IPostApi {
  Future<Response> getPosts();
}

@Injectable(as: IPostApi)
class PostApi extends IPostApi {
  final DioClient _dioClient;

  PostApi(this._dioClient);

  @override
  Future<Response> getPosts() async {
    try {
      final Response res = await _dioClient.get(EndPoints.posts);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
