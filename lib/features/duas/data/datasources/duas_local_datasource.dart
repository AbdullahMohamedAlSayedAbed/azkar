import '../models/dua_model.dart';

class DuasLocalDataSource {
  static const List<DuaModel> rizqDuas = [
    DuaModel(
      id: 'rizq_1',
      text:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا',
      reference: 'رواه ابن ماجه',
      category: 'rizq',
    ),
    DuaModel(
      id: 'rizq_2',
      text:
          'اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
      reference: 'رواه الترمذي',
      category: 'rizq',
    ),
  ];

  static const List<DuaModel> shifaDuas = [
    DuaModel(
      id: 'shifa_1',
      text:
          'أَذْهِبِ الْبَاسَ رَبَّ النَّاسِ، وَاشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمًا',
      reference: 'متفق عليه',
      category: 'shifa',
    ),
    DuaModel(
      id: 'shifa_2',
      text:
          'بِاسْمِ اللَّهِ (3) أَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ (7)',
      reference: 'رواه مسلم',
      category: 'shifa',
    ),
  ];

  static List<DuaModel> getByCategory(String category) {
    switch (category) {
      case 'rizq':
        return rizqDuas;
      case 'shifa':
        return shifaDuas;
      default:
        return [];
    }
  }
}
