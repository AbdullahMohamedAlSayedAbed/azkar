import 'package:azkar/features/Auth/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';

class SingUpView extends StatelessWidget {
  const SingUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const SignUpViewBody(),
    );
  }
}
