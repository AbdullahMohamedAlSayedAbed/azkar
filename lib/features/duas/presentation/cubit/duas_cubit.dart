import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/dua.dart';
import '../../domain/usecases/get_duas_by_category.dart';

// States
abstract class DuasState extends Equatable {
  const DuasState();
  @override
  List<Object?> get props => [];
}

class DuasInitial extends DuasState {}

class DuasLoading extends DuasState {}

class DuasLoaded extends DuasState {
  final List<Dua> duas;
  const DuasLoaded(this.duas);
  @override
  List<Object?> get props => [duas];
}

class DuasError extends DuasState {
  final String message;
  const DuasError(this.message);
  @override
  List<Object?> get props => [message];
}

// Cubit
class DuasCubit extends Cubit<DuasState> {
  final GetDuasByCategory getDuasByCategory;

  DuasCubit({required this.getDuasByCategory}) : super(DuasInitial());

  Future<void> loadDuas(String category) async {
    emit(DuasLoading());
    final result = await getDuasByCategory(category);
    result.fold(
      (failure) => emit(DuasError(failure.message)),
      (duas) => emit(DuasLoaded(duas)),
    );
  }
}
