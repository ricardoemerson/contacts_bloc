import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_register_cubit.freezed.dart';
part 'contact_register_state.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterState> {
  final ContactRepository _contactRepository;

  ContactRegisterCubit({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactRegisterState.initial());

  Future<void> save(ContactModel contact) async {
    try {
      emit(const ContactRegisterState.loading());

      await Future.delayed(const Duration(seconds: 2));

      await _contactRepository.create(contact);

      emit(const ContactRegisterState.success());
    } on Exception catch (err, s) {
      const message = 'Erro ao salvar um novo contato';

      log(message, error: err, stackTrace: s);

      emit(const ContactRegisterState.error(message: message));
    }
  }
}
