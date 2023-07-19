import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact_model.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                BlocSelector<ContactListBloc, ContactListState, List<ContactModel>>(
                  selector: (state) {
                    return state.maybeWhen(
                      data: (contacts) => contacts,
                      orElse: () => <ContactModel>[],
                    );
                  },
                  builder: (context, contacts) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];

                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.email),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
