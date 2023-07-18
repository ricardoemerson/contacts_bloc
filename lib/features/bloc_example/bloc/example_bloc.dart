import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removeName);
  }

  FutureOr<void> _findNames(ExampleFindNameEvent event, Emitter<ExampleState> emit) async {
    final names = ['Ricardo Emerson', 'Academia do Flutter', 'Dart', 'Flutter', 'Bloc'];

    await Future.delayed(const Duration(seconds: 2));

    emit(ExampleData(names: names));
  }

  FutureOr<void> _removeName(ExampleRemoveNameEvent event, Emitter<ExampleState> emit) async {
    final stateExample = state;

    if (stateExample is ExampleData) {
      final names = [...stateExample.names];
      names.retainWhere((element) => element != event.name);

      emit(ExampleData(names: names));
    }
  }
}
