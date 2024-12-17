import 'package:azkar/features/Auth/models/user_model.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/Auth/views/sign_in_view.dart';
import 'package:azkar/features/Auth/widgets/age_slider_widget.dart';
import 'package:azkar/features/Auth/widgets/custom_text_form_field.dart';
import 'package:azkar/features/Auth/widgets/drop_down_status.dart';
import 'package:azkar/features/Auth/widgets/gender_widget.dart';
import 'package:azkar/features/Auth/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _gander = '', _status = '', _age = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      _email = value!;
                    }),
                const SizedBox(height: 20),
                PasswordTextField(onSaved: (value) {
                  _password = value!;
                }),
                const SizedBox(height: 20),
                GenderWidget(
                  onAgeChanged: (value) {
                    _gander = value;
                  },
                ),
                const SizedBox(height: 20),
                DropDownStatus(
                  onAgeChanged: (value) {
                    _status = value;
                  },
                ),
                const SizedBox(height: 20),
                AgeSliderWidget(
                  onAgeChanged: (value) {
                    _age = value.toString();
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      UserModel newUser = UserModel(
                        email: _email.trim(),
                        password: _password.trim(),
                        age: double.parse(_age),
                        gender: _gander.trim(),
                        status: _status,
                      );
                      await UserStorage.saveUser(newUser);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInView()));
                    }
                  },
                  child: const Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('You have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
