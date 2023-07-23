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
  final ContactRepository _contactRepository;

  ContactListBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_ContactListEventDelete>(_delete);
  }

  FutureOr<void> _findAll(_ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(const ContactListState.loading());

      await Future.delayed(const Duration(seconds: 1));

      final contacts = await _contactRepository.findAll();

      emit(ContactListState.data(contacts: contacts));
    } on Exception catch (err, s) {
      const message = 'Erro ao buscar contatos.';

      log(message, error: err, stackTrace: s);

      emit(const ContactListState.error(message: message));
    }
  }

  Future<FutureOr<void>> _delete(
    _ContactListEventDelete event,
    Emitter<ContactListState> emit,
  ) async {
    try {
      emit(const ContactListState.loading());

      await Future.delayed(const Duration(seconds: 1));

      await _contactRepository.delete(event.contact);

      add(const ContactListEvent.findAll());
    } on Exception catch (err, s) {
      const message = 'Erro ao remover contato.';

      log(message, error: err, stackTrace: s);

      emit(const ContactListState.error(message: message));
    }
  }
}
