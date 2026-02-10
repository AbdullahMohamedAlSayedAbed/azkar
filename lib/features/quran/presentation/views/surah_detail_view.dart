import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../bloc/quran_bloc.dart';

class SurahDetailView extends StatelessWidget {
  final int surahNumber;
  final String surahName;

  const SurahDetailView({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  Widget build(BuildContext context) {
    // We reuse the QuranBloc here to get the data, or we could pass the Surah object directly.
    // For simplicity, let's assume we pass the Surah number and find it in the loaded state
    // OR we trigger an event to get specific Surah.
    // Given the current setup, we fetch all Surahs.
    // Optimization: Pass the Surah object itself in arguments if possible, or fetch it here.
    // Let's rely on the Bloc being available or re-fetch.
    // A better approach for this simple app: pass the Surah object or list index.
    // But since arguments are primitives typically, let's re-fetch or find.

    return BlocProvider(
      create: (_) => sl<QuranBloc>()..add(GetSurahsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(surahName),
        ),
        body: BlocBuilder<QuranBloc, QuranState>(
          builder: (context, state) {
            if (state is QuranLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuranLoaded) {
              final surah =
                  state.surahs.firstWhere((s) => s.number == surahNumber);
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: surah.verses.length +
                    1, // +1 for Basmalah if needed or header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Display Basmalah except for Surah Tawbah (9)
                    if (surahNumber == 9) return const SizedBox.shrink();
                    return Container(
                      padding: EdgeInsets.only(bottom: 16.h),
                      alignment: Alignment.center,
                      child: Text(
                        "بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Amiri',
                            ),
                      ),
                    );
                  }
                  final verse = surah.verses[index - 1];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${verse.text} ﴿${verse.id}﴾",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 22.sp,
                                    height: 2.0,
                                  ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                },
              );
            } else if (state is QuranError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
