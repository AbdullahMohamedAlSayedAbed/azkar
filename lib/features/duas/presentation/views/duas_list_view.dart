import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/features/duas/presentation/cubit/duas_cubit.dart';

class DuasListView extends StatelessWidget {
  final String category;
  final String title;

  const DuasListView({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DuasCubit>()..loadDuas(category),
      child: _DuasListContent(title: title),
    );
  }
}

class _DuasListContent extends StatelessWidget {
  final String title;

  const _DuasListContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<DuasCubit, DuasState>(
        builder: (context, state) {
          if (state is DuasLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DuasLoaded) {
            if (state.duas.isEmpty) {
              return const Center(child: Text('لا توجد أدعية حالياً'));
            }
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.duas.length,
              itemBuilder: (context, index) {
                final dua = state.duas[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          dua.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Amiri',
                            height: 1.5,
                          ),
                        ),
                        if (dua.reference != null) ...[
                          SizedBox(height: 12.h),
                          Text(
                            dua.reference!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is DuasError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
