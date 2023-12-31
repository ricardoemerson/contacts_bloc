import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact_model.dart';
import '../../../widgets/loader.dart';
import 'bloc/contact_list_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final readContext = context.read<ContactListBloc>();

          await Navigator.pushNamed(context, '/contacts/register');

          readContext.add(const ContactListEvent.findAll());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            error: (error) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    error,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactListBloc, ContactListState>(
                    selector: (state) {
                      return state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                    },
                  ),
                  BlocSelector<ContactListBloc, ContactListState, List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => <ContactModel>[],
                      );
                    },
                    builder: (context, contacts) {
                      return RefreshIndicator(
                        onRefresh: () async =>
                            context.read<ContactListBloc>()..add(const ContactListEvent.findAll()),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];

                            return ListTile(
                              onTap: () async {
                                final readContext = context.read<ContactListBloc>();

                                await Navigator.pushNamed(
                                  context,
                                  '/contacts/update',
                                  arguments: contact,
                                );

                                readContext.add(const ContactListEvent.findAll());
                              },
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                              trailing: IconButton(
                                onPressed: () {
                                  context
                                      .read<ContactListBloc>()
                                      .add(ContactListEvent.delete(contact: contact));
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
