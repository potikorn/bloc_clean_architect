import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/params/post_limit_params.dart';
import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/domain/use_cases/get_posts.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return ((events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  });
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(GetPostsUseCase getPostsUseCase)
      : _getPostsUseCase = getPostsUseCase,
        super(const PostState()) {
    on<GetPostList>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetPostsUseCase _getPostsUseCase;

  void _onPostFetched(
    GetPostList event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _getPostsUseCase.call(
          params: PostListParams(limit: 20),
        );
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      final posts = await _getPostsUseCase.call(
          params: PostListParams(start: state.posts.length, limit: 20));
      await Future.delayed(const Duration(milliseconds: 800));
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
