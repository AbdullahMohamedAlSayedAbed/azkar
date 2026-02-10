import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/surah.dart';
import '../../domain/usecases/get_surahs.dart';

// Events
abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

class GetSurahsEvent extends QuranEvent {}

// States
abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;

  const QuranLoaded(this.surahs);

  @override
  List<Object> get props => [surahs];
}

class QuranError extends QuranState {
  final String message;

  const QuranError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final GetSurahs getSurahs;

  QuranBloc({required this.getSurahs}) : super(QuranInitial()) {
    on<GetSurahsEvent>(_onGetSurahs);
  }

  Future<void> _onGetSurahs(
      GetSurahsEvent event, Emitter<QuranState> emit) async {
    emit(QuranLoading());
    final result = await getSurahs(NoParams());
    result.fold(
      (failure) => emit(QuranError(failure.message)),
      (surahs) => emit(QuranLoaded(surahs)),
    );
  }
}
