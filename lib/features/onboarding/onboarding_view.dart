import 'package:azkar/constants.dart';
import 'package:azkar/features/home/views/home_view.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/onboarding/widgets/custom_dot_indicator.dart';
import 'package:azkar/features/onboarding/widgets/custom_skip_button.dart';
import 'package:azkar/features/onboarding/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/IMG-20241213-WA0008.jpg",
      "title": "ابدأ يومك بالأذكار",
      "description":
          "أذكار المسلم تساعدك على تذكر الله دائمًا، وتبقيك مطمئنًا طوال اليوم."
    },
    {
      "image": "assets/images/IMG-20241213-WA0009.jpg",
      "title": "قراءة الأذكار بسهولة",
      "description": "واجهة بسيطة وسهلة تتيح لك قراءة الأذكار في أي وقت."
    },
    {
      "image": "assets/images/IMG-20241213-WA0010.jpg",
      "title": "تذكير يومي",
      "description": "الحصول على إشعارات يومية لتذكيرك بالأذكار."
    },
  ];

  PageController? controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => OnboardingContent(
                    image: onboardingData[index]["image"]!,
                    title: onboardingData[index]["title"]!,
                    description: onboardingData[index]["description"]!,
                  ),
                ),
                if (currentPage != onboardingData.length - 1)
                  Positioned(
                    right: 20,
                    top: 30,
                    child: CustomSkipButton(onPressed: navigateToNextScreen),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => CustomDotIndicator(
                      isActive: currentPage == index,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage == 2) {
                        navigateToNextScreen();
                      } else {
                        setState(() {
                          controller!.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                          );
                          currentPage = controller!.page!.toInt();
                        });
                      }
                    },
                    child: Text(
                      currentPage == 2 ? "إنهاء" : "التالي",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen() {
    Preferences.saveData(key: isVisitedOnBoarding, value: true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }
}
