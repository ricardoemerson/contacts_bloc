import 'package:dio/dio.dart';

import '../models/contact_model.dart';

class ContactRepository {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://192.168.1.107:8080/contacts');

    return response.data?.map<ContactModel>((contact) => ContactModel.fromMap(contact)).toList();
  }

  Future<void> create(ContactModel contact) async {
    await Dio().post(
      'http://192.168.1.107:8080/contacts',
      data: contact.toMap(),
    );
  }

  Future<void> update(ContactModel contact) async {
    await Dio().put(
      'http://192.168.1.107:8080/contacts/${contact.id}',
      data: contact.toMap(),
    );
  }

  Future<void> delete(ContactModel contact) async {
    await Dio().delete(
      'http://192.168.1.107:8080/contacts/${contact.id}',
    );
  }
}
