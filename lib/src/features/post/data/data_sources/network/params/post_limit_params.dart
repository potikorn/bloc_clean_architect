import 'package:bloc_clean_architect/src/core/data/network/base_params.dart';

class PostListParams extends BaseParams {
  final int start;
  final int limit;

  PostListParams({this.start = 0, this.limit = 10});

  @override
  List<Object?> get props => [start, limit];

  @override
  Map<String, String> toMap() {
    return {
      "_start": start.toString(),
      "_limit": limit.toString(),
    };
  }
}
