import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  const PostModel({
    this.userId,
    this.id,
    this.title = '',
    this.body = '',
  });

  static PostModel empty() => const PostModel();

  @override
  List<Object?> get props => [userId, id, title, body];
}
