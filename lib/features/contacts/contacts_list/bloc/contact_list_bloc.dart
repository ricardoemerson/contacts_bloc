import 'dart:async';

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
    final contacts = await _repository.findAll();

    emit(ContactListState.data(contacts: contacts));
  }
}
