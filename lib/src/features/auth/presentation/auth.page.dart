import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/custom_text_form_field.dart';
import '../data/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSigningIn = true;

  // bool get _isFormInvalid => [
  //       _emailController.text.isEmpty,
  //       _passwordController.text.isEmpty,
  //     ].any((isNotValid) => isNotValid);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                Text(
                  _isSigningIn ? "Sign in" : "Sign up",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  label: "Email",
                  hint: "Type in your Email",
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline,
                  label: "Password",
                  hint: "Type in your Password",
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        child: MaterialButton(
                          onPressed: _changeAuthType,
                          color: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            _isSigningIn
                                ? "No account? Sign up"
                                : "Already have an account?",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Consumer(
                      builder: (context, ref, child) {
                        return Expanded(
                          child: SizedBox(
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: () => _authenticate(ref),
                              color: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                _isSigningIn ? "Sign in" : "Sign up",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeAuthType() {
    setState(() => _isSigningIn = !_isSigningIn);
  }

  void _authenticate(WidgetRef ref) {
    if (_isSigningIn) {
      ref.read(authControllerProvider.notifier).signIn(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
    } else {
      ref.read(authControllerProvider.notifier).signUp(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
    }
  }
}
