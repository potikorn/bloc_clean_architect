import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_clean_architect/src/core/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_clean_architect/src/di/inject.dart';
import 'package:bloc_clean_architect/src/features/home/presentation/home_page.dart';
import 'package:bloc_clean_architect/src/features/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController usernameTextController;
  late final TextEditingController passwordTextController;
  late final LoginController loginController;

  final loginFormKey = GlobalKey<FormState>();
  final userNameKey = const Key('loginForm_usernameInput_textField');
  final passwordKey = const Key('loginForm_passwordInput_textField');

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    loginController = LoginController(
      authenticationRepository: getIt<AuthenticationRepository>(),
    );
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                TextFormField(
                  key: userNameKey,
                  controller: usernameTextController,
                  decoration: const InputDecoration(
                    labelText: 'username',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'required';
                    }
                  },
                ),
                TextFormField(
                  key: passwordKey,
                  controller: passwordTextController,
                  decoration: const InputDecoration(
                    labelText: 'password',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'required';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!(loginFormKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      final result = await loginController.onSubmitted(
                        username: usernameTextController.text,
                        password: passwordTextController.text,
                      );
                      if (result && mounted) {
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const HomePage()),
                          (route) => false,
                        );
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('invalid credentials')));
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
