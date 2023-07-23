import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
import '../../../../repositories/contact_repository.dart';

part 'contact_list_cubit.freezed.dart';
part 'contact_list_state.dart';

class ContactListCubit extends Cubit<ContactListState> {
  final ContactRepository _contactRepository;

  ContactListCubit({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactListState.initial());

  Future<void> findAll() async {
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

  Future<void> delete(ContactModel contact) async {
    try {
      emit(const ContactListState.loading());

      await Future.delayed(const Duration(seconds: 1));

      await _contactRepository.delete(contact);

      findAll();
    } on Exception catch (err, s) {
      const message = 'Erro ao remover contato.';

      log(message, error: err, stackTrace: s);

      emit(const ContactListState.error(message: message));
    }
  }
}
