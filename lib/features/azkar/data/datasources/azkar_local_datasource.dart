/// Azkar Local Data Source
/// Contains all azkar data organized by category
library;

import 'package:azkar/features/azkar/data/models/zikr_model.dart';

class AzkarLocalDataSource {
  // Morning Azkar
  static final List<ZikrModel> morningAzkar = [
    const ZikrModel(
      id: 'morning_1',
      text:
          'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَـذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَـذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'morning',
      order: 1,
    ),
    const ZikrModel(
      id: 'morning_2',
      text:
          'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
      reference: 'رواه الترمذي',
      repeatCount: 1,
      category: 'morning',
      order: 2,
    ),
    const ZikrModel(
      id: 'morning_3',
      text:
          'اللَّهُمَّ أَنْتَ رَبِّي لاَ إِلَـهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوبَ إِلاَّ أَنْتَ',
      reference: 'رواه البخاري',
      note: 'سيد الاستغفار',
      repeatCount: 1,
      category: 'morning',
      order: 3,
    ),
    const ZikrModel(
      id: 'morning_4',
      text:
          'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
      reference: 'رواه أبو داود',
      note: 'من قالها أعتقه الله من النار',
      repeatCount: 4,
      category: 'morning',
      order: 4,
    ),
    const ZikrModel(
      id: 'morning_5',
      text:
          'اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
      reference: 'رواه أبو داود',
      note: 'من قالها أدى شكر يومه',
      repeatCount: 1,
      category: 'morning',
      order: 5,
    ),
    const ZikrModel(
      id: 'morning_6',
      text:
          'حَسْبِيَ اللَّهُ لَا إِلَـهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
      reference: 'رواه ابن السني',
      repeatCount: 7,
      category: 'morning',
      order: 6,
    ),
    const ZikrModel(
      id: 'morning_7',
      text:
          'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      reference: 'رواه أبو داود والترمذي',
      note: 'لم يضره شيء',
      repeatCount: 3,
      category: 'morning',
      order: 7,
    ),
    const ZikrModel(
      id: 'morning_8',
      text:
          'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ',
      reference: 'رواه أبو داود',
      repeatCount: 3,
      category: 'morning',
      order: 8,
    ),
    const ZikrModel(
      id: 'morning_9',
      text:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ',
      reference: 'رواه أبو داود',
      repeatCount: 3,
      category: 'morning',
      order: 9,
    ),
    const ZikrModel(
      id: 'morning_10',
      text:
          'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
      reference: 'رواه الحاكم',
      repeatCount: 1,
      category: 'morning',
      order: 10,
    ),
    const ZikrModel(
      id: 'morning_11',
      text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      reference: 'رواه مسلم',
      note: 'من قالها غُفرت له ذنوبه وإن كانت مثل زبد البحر',
      repeatCount: 100,
      category: 'morning',
      order: 11,
    ),
    const ZikrModel(
      id: 'morning_12',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      reference: 'متفق عليه',
      note: 'كتبت له مائة حسنة ومحيت عنه مائة سيئة وكانت له حرزاً من الشيطان',
      repeatCount: 100,
      category: 'morning',
      order: 12,
    ),
    const ZikrModel(
      id: 'morning_13',
      text:
          'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ',
      reference: 'رواه مسلم',
      repeatCount: 3,
      category: 'morning',
      order: 13,
    ),
    const ZikrModel(
      id: 'morning_14',
      text: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      reference: 'رواه البخاري ومسلم',
      repeatCount: 100,
      category: 'morning',
      order: 14,
    ),
  ];

  // Evening Azkar
  static final List<ZikrModel> eveningAzkar = [
    const ZikrModel(
      id: 'evening_1',
      text:
          'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَـذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَـذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'evening',
      order: 1,
    ),
    const ZikrModel(
      id: 'evening_2',
      text:
          'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
      reference: 'رواه الترمذي',
      repeatCount: 1,
      category: 'evening',
      order: 2,
    ),
    const ZikrModel(
      id: 'evening_3',
      text:
          'اللَّهُمَّ أَنْتَ رَبِّي لاَ إِلَـهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوبَ إِلاَّ أَنْتَ',
      reference: 'رواه البخاري',
      note: 'سيد الاستغفار - من قالها حين يمسي فمات دخل الجنة',
      repeatCount: 1,
      category: 'evening',
      order: 3,
    ),
    const ZikrModel(
      id: 'evening_4',
      text:
          'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
      reference: 'رواه أبو داود',
      note: 'من قالها أعتقه الله من النار',
      repeatCount: 4,
      category: 'evening',
      order: 4,
    ),
    const ZikrModel(
      id: 'evening_5',
      text:
          'اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
      reference: 'رواه أبو داود',
      note: 'من قالها أدى شكر ليلته',
      repeatCount: 1,
      category: 'evening',
      order: 5,
    ),
    const ZikrModel(
      id: 'evening_6',
      text:
          'حَسْبِيَ اللَّهُ لَا إِلَـهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
      reference: 'رواه ابن السني',
      repeatCount: 7,
      category: 'evening',
      order: 6,
    ),
    const ZikrModel(
      id: 'evening_7',
      text:
          'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      reference: 'رواه أبو داود والترمذي',
      note: 'لم يضره شيء',
      repeatCount: 3,
      category: 'evening',
      order: 7,
    ),
    const ZikrModel(
      id: 'evening_8',
      text: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      reference: 'رواه مسلم',
      repeatCount: 3,
      category: 'evening',
      order: 8,
    ),
    const ZikrModel(
      id: 'evening_9',
      text:
          'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ',
      reference: 'رواه أبو داود',
      repeatCount: 3,
      category: 'evening',
      order: 9,
    ),
    const ZikrModel(
      id: 'evening_10',
      text:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ',
      reference: 'رواه أبو داود',
      repeatCount: 3,
      category: 'evening',
      order: 10,
    ),
    const ZikrModel(
      id: 'evening_11',
      text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      reference: 'رواه مسلم',
      note: 'من قالها غُفرت له ذنوبه وإن كانت مثل زبد البحر',
      repeatCount: 100,
      category: 'evening',
      order: 11,
    ),
    const ZikrModel(
      id: 'evening_12',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      reference: 'متفق عليه',
      repeatCount: 100,
      category: 'evening',
      order: 12,
    ),
  ];

  // Sleep Azkar
  static final List<ZikrModel> sleepAzkar = [
    const ZikrModel(
      id: 'sleep_1',
      text: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      reference: 'رواه البخاري',
      repeatCount: 1,
      category: 'sleep',
      order: 1,
    ),
    const ZikrModel(
      id: 'sleep_2',
      text:
          'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، فَإِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا، بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ',
      reference: 'رواه البخاري ومسلم',
      repeatCount: 1,
      category: 'sleep',
      order: 2,
    ),
    const ZikrModel(
      id: 'sleep_3',
      text:
          'اللَّهُمَّ خَلَقْتَ نَفْسِي وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْيَاهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا. اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'sleep',
      order: 3,
    ),
    const ZikrModel(
      id: 'sleep_4',
      text: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ',
      reference: 'رواه أبو داود والترمذي',
      repeatCount: 3,
      category: 'sleep',
      order: 4,
    ),
    const ZikrModel(
      id: 'sleep_5',
      text: 'سُبْحَانَ اللَّهِ',
      reference: 'متفق عليه',
      repeatCount: 33,
      category: 'sleep',
      order: 5,
    ),
    const ZikrModel(
      id: 'sleep_6',
      text: 'الْحَمْدُ لِلَّهِ',
      reference: 'متفق عليه',
      repeatCount: 33,
      category: 'sleep',
      order: 6,
    ),
    const ZikrModel(
      id: 'sleep_7',
      text: 'اللَّهُ أَكْبَرُ',
      reference: 'متفق عليه',
      repeatCount: 34,
      category: 'sleep',
      order: 7,
    ),
    const ZikrModel(
      id: 'sleep_8',
      text:
          'اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لَا مَلْجَأَ وَلَا مَنْجَا مِنْكَ إِلَّا إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ',
      reference: 'رواه البخاري ومسلم',
      note: 'اجعلهن آخر ما تقول',
      repeatCount: 1,
      category: 'sleep',
      order: 8,
    ),
  ];

  // Wake Up Azkar
  static final List<ZikrModel> wakeUpAzkar = [
    const ZikrModel(
      id: 'wakeup_1',
      text:
          'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      reference: 'رواه البخاري',
      repeatCount: 1,
      category: 'wakeup',
      order: 1,
    ),
    const ZikrModel(
      id: 'wakeup_2',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ',
      reference: 'رواه البخاري',
      note: 'ثم دعا استجيب له',
      repeatCount: 1,
      category: 'wakeup',
      order: 2,
    ),
  ];

  // After Prayer Azkar
  static final List<ZikrModel> afterPrayerAzkar = [
    const ZikrModel(
      id: 'prayer_1',
      text: 'أَسْتَغْفِرُ اللَّهَ',
      reference: 'رواه مسلم',
      repeatCount: 3,
      category: 'afterPrayer',
      order: 1,
    ),
    const ZikrModel(
      id: 'prayer_2',
      text:
          'اللَّهُمَّ أَنْتَ السَّلَامُ، وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'afterPrayer',
      order: 2,
    ),
    const ZikrModel(
      id: 'prayer_3',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      reference: 'رواه البخاري ومسلم',
      repeatCount: 1,
      category: 'afterPrayer',
      order: 3,
    ),
    const ZikrModel(
      id: 'prayer_4',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ، لَا إِلَهَ إِلَّا اللَّهُ، وَلَا نَعْبُدُ إِلَّا إِيَّاهُ، لَهُ النِّعْمَةُ وَلَهُ الْفَضْلُ وَلَهُ الثَّنَاءُ الْحَسَنُ، لَا إِلَهَ إِلَّا اللَّهُ مُخْلِصِينَ لَهُ الدِّينَ وَلَوْ كَرِهَ الْكَافِرُونَ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'afterPrayer',
      order: 4,
    ),
    const ZikrModel(
      id: 'prayer_5',
      text: 'سُبْحَانَ اللَّهِ',
      reference: 'رواه مسلم',
      repeatCount: 33,
      category: 'afterPrayer',
      order: 5,
    ),
    const ZikrModel(
      id: 'prayer_6',
      text: 'الْحَمْدُ لِلَّهِ',
      reference: 'رواه مسلم',
      repeatCount: 33,
      category: 'afterPrayer',
      order: 6,
    ),
    const ZikrModel(
      id: 'prayer_7',
      text: 'اللَّهُ أَكْبَرُ',
      reference: 'رواه مسلم',
      repeatCount: 33,
      category: 'afterPrayer',
      order: 7,
    ),
    const ZikrModel(
      id: 'prayer_8',
      text:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      reference: 'رواه مسلم',
      note: 'تمام المائة',
      repeatCount: 1,
      category: 'afterPrayer',
      order: 8,
    ),
  ];

  // Ruqyah
  static final List<ZikrModel> ruqyahAzkar = [
    const ZikrModel(
      id: 'ruqyah_1',
      text:
          'بِسْمِ اللَّهِ أَرْقِيكَ، مِنْ كُلِّ شَيْءٍ يُؤْذِيكَ، مِنْ شَرِّ كُلِّ نَفْسٍ أَوْ عَيْنِ حَاسِدٍ، اللَّهُ يَشْفِيكَ، بِسْمِ اللَّهِ أَرْقِيكَ',
      reference: 'رواه مسلم',
      repeatCount: 1,
      category: 'ruqyah',
      order: 1,
    ),
    const ZikrModel(
      id: 'ruqyah_2',
      text:
          'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ، مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ، وَمِنْ كُلِّ عَيْنٍ لَامَّةٍ',
      reference: 'رواه البخاري',
      repeatCount: 1,
      category: 'ruqyah',
      order: 2,
    ),
  ];

  /// Get azkar by category
  static List<ZikrModel> getByCategory(String category) {
    switch (category) {
      case 'morning':
        return morningAzkar;
      case 'evening':
        return eveningAzkar;
      case 'sleep':
        return sleepAzkar;
      case 'wakeup':
        return wakeUpAzkar;
      case 'afterPrayer':
        return afterPrayerAzkar;
      case 'ruqyah':
        return ruqyahAzkar;
      default:
        return [];
    }
  }

  /// Get all categories
  static List<String> get categories => [
        'morning',
        'evening',
        'sleep',
        'wakeup',
        'afterPrayer',
        'ruqyah',
      ];
}
