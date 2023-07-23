import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact_model.dart';
import '../../../widgets/loader.dart';
import 'cubit/contact_list_cubit.dart';

class ContactsListCubitPage extends StatelessWidget {
  const ContactsListCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactsListPage'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final readContext = context.read<ContactListCubit>();

          await Navigator.pushNamed(context, '/contacts-cubit/register');

          readContext.findAll();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListCubit, ContactListState>(
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
                  Loader<ContactListCubit, ContactListState>(
                    selector: (state) {
                      return state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                    },
                  ),
                  BlocSelector<ContactListCubit, ContactListState, List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => <ContactModel>[],
                      );
                    },
                    builder: (context, contacts) {
                      return RefreshIndicator(
                        onRefresh: () async => context.read<ContactListCubit>().findAll(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];

                            return ListTile(
                              onTap: () async {
                                final readContext = context.read<ContactListCubit>();

                                await Navigator.pushNamed(
                                  context,
                                  '/contacts/update',
                                  arguments: contact,
                                );

                                readContext.findAll();
                              },
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                              trailing: IconButton(
                                onPressed: () {
                                  context.read<ContactListCubit>().delete(contact);
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
