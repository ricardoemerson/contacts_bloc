import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_bloc.freezed.dart';
part 'freezed_event.dart';
part 'freezed_state.dart';

class FreezedBloc extends Bloc<FreezedEvent, FreezedState> {
  FreezedBloc() : super(const FreezedState.initial()) {
    on<_FreezedFindNamesEvent>(_findNames);
    on<_FreezedAddNameEvent>(_addName);
    on<_FreezedRemoveNameEvent>(_removeName);
  }

  FutureOr<void> _findNames(
    _FreezedFindNamesEvent event,
    Emitter<FreezedState> emit,
  ) async {
    emit(const FreezedState.loading());

    final names = ['Ricardo Emerson', 'Academia do Flutter', 'Dart', 'Flutter', 'Bloc'];

    await Future.delayed(const Duration(seconds: 2));

    emit(FreezedState.data(names: names));
  }

  Future<FutureOr<void>> _addName(_FreezedAddNameEvent event, Emitter<FreezedState> emit) async {
    // final names = state.maybeWhen(
    //   data: (names) => [...names, event.name],
    //   orElse: () => <String>[event.name],
    // );

    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => <String>[event.name],
    );

    emit(FreezedState.showBanner(names: names, message: 'Aguarde, nome sendo inserido!'));

    await Future.delayed(const Duration(seconds: 2));

    final newNames = [...names, event.name];

    emit(FreezedState.data(names: newNames));
  }

  FutureOr<void> _removeName(_FreezedRemoveNameEvent event, Emitter<FreezedState> emit) {
    final names = state.maybeWhen(
      data: (names) => names.where((element) => element != event.name).toList(),
      orElse: () => <String>[],
    );

    emit(FreezedState.data(names: names));
  }
}
