import 'dart:convert';
import 'dart:io';

import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/params/post_limit_params.dart';
import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/post_api.dart';
import 'package:bloc_clean_architect/src/features/post/data/entities/post_entity.dart';
import 'package:bloc_clean_architect/src/features/post/data/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockPostApi extends Mock implements PostApi {}

class MockResponse extends Mock implements Response {}

void main() {
  late PostApi postApi;
  late PostRepository postRepository;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUpAll(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    postApi = MockPostApi();
    postRepository = PostRepository(postApi);
    registerFallbackValue(PostListParams());
  });

  group('postRepository', () {
    test('return post list from API', () async {
      const route = '/posts';
      final rawJson = File('test/features/post/test_resources/post_list.json')
          .readAsStringSync();
      final payload = PostListParams();

      dioAdapter.onGet(route, (server) {
        return server.reply(200, jsonDecode(rawJson));
      });
      final response = await dio.get(route);

      when(() => postApi.getPosts(any())).thenAnswer((_) async => response);

      final expectedPosts =
          ((response.data) as List).map((e) => PostEntity.fromJson(e)).toList();
      final actual = await postRepository.getPosts(payload);

      expect(actual, expectedPosts);
    });
  });
}
