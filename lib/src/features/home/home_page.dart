import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/data/auth_controller.dart';

// import '../core/widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut(context);
                },
                child: const Text("Sign Out"),
              );
            },
          ),
        ],
      ),
    );
  }
}
