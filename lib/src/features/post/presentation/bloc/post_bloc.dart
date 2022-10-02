import 'dart:io';

import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/domain/use_cases/get_posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(GetPostsUseCase getPostsUseCase)
      : _getPostsUseCase = getPostsUseCase,
        super(PostInitial()) {
    on<GetPostList>(_getPostList);
  }

  final GetPostsUseCase _getPostsUseCase;

  void _getPostList(PostEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      final postsList = await _getPostsUseCase.call();
      emit(PostSuccess(postsList));
    } on SocketException {
      emit(const PostError('Failed to fetch data. is your device online'));
    }
  }
}
