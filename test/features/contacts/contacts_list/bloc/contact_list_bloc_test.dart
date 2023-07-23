import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts/contacts_list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contact_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactRepository extends Mock implements ContactRepository {}

void main() {
  // Declaração.
  late ContactRepository contactRepository;
  late ContactListBloc bloc;
  late List<ContactModel> contacts;

  // Preparação.
  setUp(() {
    contactRepository = MockContactRepository();
    bloc = ContactListBloc(contactRepository: contactRepository);
    contacts = [
      ContactModel(id: 1, name: 'Ricardo Emerson', email: 'ricardo_emerson@yahoo.com.br'),
      ContactModel(id: 2, name: 'Pedro', email: 'pedro@gmail.com'),
      ContactModel(id: 3, name: 'Aírton', email: 'airton@outlook.com'),
      ContactModel(id: 4, name: 'Márcio', email: 'marcio@gmail.com'),
    ];
  });

  // Execução.
  blocTest<ContactListBloc, ContactListState>(
    'Deve buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    setUp: () {
      when(() => contactRepository.findAll()).thenAnswer((_) async => contacts);
    },
    expect: () => [
      const ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );

  blocTest<ContactListBloc, ContactListState>(
    'Deve retornar erro ao buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    setUp: () {
      when(() => contactRepository.findAll()).thenThrow(Exception());
    },
    expect: () => [
      const ContactListState.loading(),
      const ContactListState.error(message: 'Erro ao buscar contatos.'),
    ],
  );
}
