import 'package:bloc_clean_architect/src/core/domain/use_case.dart';
import 'package:bloc_clean_architect/src/features/post/data/data_sources/network/params/post_limit_params.dart';
import 'package:bloc_clean_architect/src/features/post/domain/models/post_model.dart';
import 'package:bloc_clean_architect/src/features/post/domain/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetPostsUseCase extends UseCase<List<PostModel>, PostListParams> {
  final IPostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<List<PostModel>> call({PostListParams? params}) async {
    return await _postRepository.getPosts(params ?? PostListParams());
  }
}
