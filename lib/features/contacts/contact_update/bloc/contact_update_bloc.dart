import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_update_bloc.freezed.dart';
part 'contact_update_event.dart';
part 'contact_update_state.dart';

class ContactUpdateBloc extends Bloc<ContactUpdateEvent, ContactUpdateState> {
  final ContactRepository _contactRepository;

  ContactUpdateBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactUpdateState.initial()) {
    on<ContactUpdateEvent>(_update);
  }

  Future<FutureOr<void>> _update(ContactUpdateEvent event, Emitter<ContactUpdateState> emit) async {
    try {
      emit(const ContactUpdateState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contact = ContactModel(id: event.id, name: event.name, email: event.email);

      await _contactRepository.update(contact);

      emit(const ContactUpdateState.success());
    } on Exception catch (err, s) {
      const message = 'Erro ao alterar contato.';

      log(message, error: err, stackTrace: s);

      emit(const ContactUpdateState.error(message: message));
    }
  }
}
