part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostModel> postListModel;
  const PostSuccess(this.postListModel);
}

class PostError extends PostState {
  final String? message;
  const PostError(this.message);
}
