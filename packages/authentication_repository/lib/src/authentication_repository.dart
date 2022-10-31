import 'dart:async';

enum AuthenticationStatus {
  unknown,
  unauthenticated,
  authenticated,
  invalidCredentials,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    // FIXME post authentication to server
    try {
      if (username == 'a@a.com' && password == '1234') {
        await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(AuthenticationStatus.authenticated),
        );
      } else {
        _controller.add(AuthenticationStatus.invalidCredentials);
        throw Exception('invalid credentials');
      }
    } catch (e) {
      print('enter this error');
      rethrow;
    }
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
