import 'package:bloc_clean_architect/src/core/domain/use_case.dart';
import 'package:bloc_clean_architect/src/features/post/data/repository/post_repository.dart';
import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/domain/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetPostsUseCase extends UseCase<List<PostModel>, NoParams> {
  final IPostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<List<PostModel>> call({NoParams? params}) async {
    return await _postRepository.getPosts();
  }
}
