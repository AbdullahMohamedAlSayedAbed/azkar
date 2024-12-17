import 'package:azkar/features/home/dummy/moring_zekar.dart';
import 'package:azkar/features/home/dummy/names.dart';
import 'package:azkar/features/home/views/azekr_wake_up_view.dart';
import 'package:azkar/features/home/views/details_view.dart';
import 'package:azkar/features/home/views/legal_quqyah_view.dart';
import 'package:azkar/features/home/views/names_allah_view.dart';
import 'package:azkar/features/home/widget/card_home_widget.dart';
import 'package:azkar/features/home/views/counter_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  static const List<Map<String, dynamic>> items = [
    {'icon': Icons.nights_stay, 'title': 'أذكار المساء'},
    {'icon': Icons.wb_sunny, 'title': 'أذكار الصباح'},
    {'icon': Icons.favorite, 'title': 'أسماء الله الحسنى'},
    {'icon': Icons.mosque, 'title': 'أسماء رسول الله'},
    {'icon': Icons.handshake, 'title': "التسابيح"},
    {'icon': Icons.account_balance_wallet, 'title': "مسبحة الكترونية"},
    {'icon': Icons.check, 'title': 'بعد الصلاة'},
    {'icon': Icons.alarm, 'title': 'الاستيقاظ'},
    {'icon': Icons.bedtime, 'title': 'قبل النوم'},
    {'icon': Icons.book, 'title': 'الرقية الشرعية'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      children: [
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsView(
                            azkarList: azkarEvening,
                            title: 'أذكار المساء',
                          )));
            },
            child: CardHomeWidget(items: items[0])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsView(
                            azkarList: azkarList,
                            title: 'أذكار الصباح',
                          )));
            },
            child: CardHomeWidget(items: items[1])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllahNamesView(
                            title: "أسماء الله الحسنى",
                            names: names,
                          )));
            },
            child: CardHomeWidget(items: items[2])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllahNamesView(
                            names: namesMohamed,
                            title: "اسماء رسول الله",
                          )));
            },
            child: CardHomeWidget(items: items[3])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsView(
                          azkarList: tasbeehList, title: "تسابيح")));
            },
            child: CardHomeWidget(items: items[4])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CounterView()));
            },
            child: CardHomeWidget(items: items[5])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsView(
                            azkarList: azkarAfterPrayer,
                            title: "أذكار بعد الصلاة",
                          )));
            },
            child: CardHomeWidget(items: items[6])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WakeUpView(
                            title: 'ذكار الاستيقاظ من النوم',
                            item: azkarWakeUpList,
                          )));
            },
            child: CardHomeWidget(items: items[7])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WakeUpView(
                            title: 'ذكار قبل النوم',
                            item: azkarSleepList,
                          )));
            },
            child: CardHomeWidget(items: items[8])),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LegalQuqyahView()));
            },
            child: CardHomeWidget(items: items[9])),
      ],
    );
  }
}
