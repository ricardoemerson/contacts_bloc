import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_register_bloc.freezed.dart';
part 'contact_register_event.dart';
part 'contact_register_state.dart';

class ContactRegisterBloc extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactRepository _repository;

  ContactRegisterBloc({required ContactRepository repository})
      : _repository = repository,
        super(const ContactRegisterState.initial()) {
    on<ContactRegisterEvent>(_save);
  }

  Future<FutureOr<void>> _save(
    ContactRegisterEvent event,
    Emitter<ContactRegisterState> emit,
  ) async {
    try {
      emit(const ContactRegisterState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contact = ContactModel(name: event.name, email: event.email);

      await _repository.create(contact);

      emit(const ContactRegisterState.success());
    } on Exception catch (err, s) {
      const message = 'Erro ao salvar um novo contato';

      log(message, error: err, stackTrace: s);

      emit(const ContactRegisterState.error(message: message));
    }
  }
}
