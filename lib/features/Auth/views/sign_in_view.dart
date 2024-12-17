import 'package:azkar/constants.dart';
import 'package:azkar/features/Auth/models/user_model.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/Auth/views/sing_up_view.dart';
import 'package:azkar/features/Auth/widgets/custom_text_form_field.dart';
import 'package:azkar/features/Auth/widgets/password_text_field.dart';
import 'package:azkar/features/home/views/home_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isRemember = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('images/images.png'),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email',
                      onSaved: (value) {
                        email = value!;
                      }),
                  const SizedBox(height: 20),
                  PasswordTextField(onSaved: (value) {
                    password = value!;
                  }),
                  const SizedBox(height: 40),
                  CheckboxListTile(
                    title: const Text('Remember Me'),
                    value: isRemember,
                    onChanged: (value) {
                      setState(() {
                        isRemember = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        List<UserModel> users = await UserStorage.getUsers();
                        bool isAuthenticated = users.any((user) =>
                            user.email == email && user.password == password);
                        if (isAuthenticated) {
                          await UserStorage.saveData(key: isAuth, value: true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                margin: EdgeInsets.all(10),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                                content: Center(
                                  child: Text(
                                    'تم تسجيل الدخول بنجاح!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                backgroundColor: Colors.red,
                                content: Center(
                                  child: Text(
                                    'البريد الإلكتروني أو كلمة المرور غير صحيحة!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          );
                        }
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingUpView()));
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
