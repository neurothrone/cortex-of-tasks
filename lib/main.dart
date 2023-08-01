import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/constants/environment_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _init();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

Future<void> _init() async {
  await dotenv.load(fileName: ".env");
  EnvironmentConstants.init();
}
