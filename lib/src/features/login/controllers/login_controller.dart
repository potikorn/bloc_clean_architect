import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoginController {
  LoginController({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super();

  final AuthenticationRepository _authenticationRepository;

  Future<bool> onSubmitted({
    required String username,
    required String password,
  }) async {
    try {
      await _authenticationRepository.login(
        username: username,
        password: password,
      );
      return true;
    } catch (_) {
      log('error login');
      return false;
    }
  }
}
