import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class EndPoints {
  EndPoints._();

  static const String baseUrl = 'https://aaajsonplaceholder.typicode.com';
  static const int receiveTimeout = 6000;
  static const int connectionTimeout = 6000;
  static const String posts = '/posts';
}

@singleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = EndPoints.baseUrl
      ..options.connectTimeout = EndPoints.connectionTimeout
      ..options.receiveTimeout = EndPoints.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
