import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_update_cubit.freezed.dart';
part 'contact_update_state.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateState> {
  final ContactRepository _contactRepository;

  ContactUpdateCubit({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactUpdateState.initial());

  Future<void> update(ContactModel contact) async {
    try {
      emit(const ContactUpdateState.loading());

      await Future.delayed(const Duration(seconds: 2));

      await _contactRepository.update(contact);

      emit(const ContactUpdateState.success());
    } on Exception catch (err, s) {
      const message = 'Erro ao alterar contato.';

      log(message, error: err, stackTrace: s);

      emit(const ContactUpdateState.error(message: message));
    }
  }
}
