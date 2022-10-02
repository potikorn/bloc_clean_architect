import 'dart:convert';
import 'dart:io';

import 'package:bloc_clean_architect/src/features/post/data/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parse to model correctly', () {
    final file = File('test/features/post/test_resources/random_post.json')
        .readAsStringSync();
    final postEntity =
        PostEntity.fromJson(jsonDecode(file) as Map<String, dynamic>);

    expect(postEntity.id, 1);
    expect(postEntity.userId, 1);
    expect(postEntity.title,
        'sunt aut facere repellat provident occaecati excepturi optio reprehenderit');
    expect(postEntity.body,
        'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto');
  });
}
