import 'dart:async';
import 'dart:developer';

import 'package:bloc_clean_architect/src/core/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_clean_architect/src/core/presentation/app.dart';
import 'package:bloc_clean_architect/src/di/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  return runZonedGuarded(() async {
    runApp(
      MultiBlocProvider(providers: [
        BlocProvider(
          create: ((context) => AuthenticationBloc(
                authenticationRepository: getIt(),
                userRepository: getIt(),
              )),
        )
      ], child: const App()),
    );
  }, (error, stack) {
    log(stack.toString());
    log(error.toString());
  });
}

class SimpleBlocObserver extends BlocObserver {}
