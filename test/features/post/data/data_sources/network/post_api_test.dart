import 'dart:io';

import 'package:bloc_clean_architect/src/core/data/network/dio_client.dart';
import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/post_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late Dio dio;
  late DioClient dioClient;
  late DioAdapter dioAdapter;

  group('postApi', () {
    setUpAll(() {
      dio = Dio();
      dioClient = MockDioClient();
      dioAdapter = DioAdapter(dio: dio);
    });
    test('get fetch should return successful response', () async {
      final postApi = PostApi(dioClient);
      const route = EndPoints.posts;
      final rawJson = File('test/features/post/test_resources/post_list.json')
          .readAsStringSync();

      dioAdapter.onGet(route, (server) {
        return server.reply(200, rawJson);
      });
      final mockResponse = await dio.get(route);

      when(() => dioClient.get(route)).thenAnswer((_) async => mockResponse);

      final response = await postApi.getPosts();
      expect(response.statusCode, 200);
      expect(response.data, rawJson);
    });
  });
}
