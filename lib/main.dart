import 'dart:async';
import 'dart:developer';

import 'package:bloc_clean_architect/src/core/presentation/app.dart';
import 'package:bloc_clean_architect/src/di/inject.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  return runZonedGuarded(() async {
    runApp(const App());
  }, (error, stack) {
    log(stack.toString());
    log(error.toString());
  });
}
