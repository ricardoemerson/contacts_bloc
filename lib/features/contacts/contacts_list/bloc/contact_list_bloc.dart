import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_list_bloc.freezed.dart';
part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository _repository;

  ContactListBloc({required ContactRepository repository})
      : _repository = repository,
        super(const ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
  }

  FutureOr<void> _findAll(_ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(const ContactListState.loading());

      await Future.delayed(const Duration(seconds: 1));

      final contacts = await _repository.findAll();

      emit(ContactListState.data(contacts: contacts));
    } on Exception catch (err, s) {
      log('err: $err', stackTrace: s);

      emit(const ContactListState.error(error: 'Erro ao buscar contatos.'));
    }
  }
}
