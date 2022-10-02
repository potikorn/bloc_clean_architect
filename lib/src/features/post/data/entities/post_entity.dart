import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';

class PostEntity extends PostModel {
  PostEntity.fromJson(Map<String, dynamic> json)
      : super(
            userId: json['userId'] as int,
            id: json['id'] as int,
            body: json['body'],
            title: json['title']);
}
