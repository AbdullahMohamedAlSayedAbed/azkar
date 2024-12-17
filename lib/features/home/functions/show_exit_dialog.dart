import 'package:azkar/constants.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/Auth/views/sign_in_view.dart';
import 'package:flutter/material.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text(
              'تأكيد الخروج',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد الخروج من التطبيق؟',
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'إلغاء',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              UserStorage.deleteData(key: isAuth);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return const SignInView();
                },
              ), (route) => false);
            },
            child: const Text(
              'خروج',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    },
  );
}
