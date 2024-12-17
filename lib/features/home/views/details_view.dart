import 'package:azkar/features/home/widget/details_view_body.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.azkarList, required this.title});
  final List<Map<String, dynamic>> azkarList;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(title),
        ),
        body: DetailsViewBody(
          azkarList: azkarList,
        ),
      ),
    );
  }
}
