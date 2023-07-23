import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/bloc_example/bloc/example_bloc.dart';
import 'features/bloc_example/bloc_example_page.dart';
import 'features/contacts/contact_register/bloc/contact_register_bloc.dart';
import 'features/contacts/contact_register/contact_register_page.dart';
import 'features/contacts/contact_update/bloc/contact_update_bloc.dart';
import 'features/contacts/contact_update/contact_update_page.dart';
import 'features/contacts/contacts_list/bloc/contact_list_bloc.dart';
import 'features/contacts/contacts_list/contacts_list_page.dart';
import 'features/contacts_cubit/contact_register_cubit/contact_register_cubit_page.dart';
import 'features/contacts_cubit/contact_register_cubit/cubit/contact_register_cubit.dart';
import 'features/contacts_cubit/contact_update_cubit/contact_update_cubit_page.dart';
import 'features/contacts_cubit/contacts_list_cubit/contacts_list_cubit_page.dart';
import 'features/contacts_cubit/contacts_list_cubit/cubit/contact_list_cubit.dart';
import 'features/freezed_example/bloc/freezed_bloc.dart';
import 'features/freezed_example/freezed_example_page.dart';
import 'home/home_page.dart';
import 'models/contact_model.dart';
import 'repositories/contact_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/bloc': (context) => BlocProvider(
                create: (context) => ExampleBloc()..add(ExampleFindNameEvent()),
                child: const BlocExamplePage(),
              ),
          '/freezed': (context) => BlocProvider(
                create: (context) => FreezedBloc()..add(const FreezedEvent.findNames()),
                child: const FreezedExamplePage(),
              ),
          '/contacts/list': (context) => BlocProvider(
                create: (context) => ContactListBloc(contactRepository: context.read())
                  ..add(const ContactListEvent.findAll()),
                child: const ContactsListPage(),
              ),
          '/contacts/register': (context) => BlocProvider(
                create: (context) => ContactRegisterBloc(contactRepository: context.read()),
                child: const ContactRegisterPage(),
              ),
          '/contacts/update': (context) {
            final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactUpdateBloc(contactRepository: context.read()),
              child: ContactUpdatePage(
                contact: contact,
              ),
            );
          },
          '/contacts-cubit/list': (context) => BlocProvider(
                create: (context) => ContactListCubit(contactRepository: context.read())..findAll(),
                child: const ContactsListCubitPage(),
              ),
          '/contacts-cubit/register': (context) => BlocProvider(
                create: (context) => ContactRegisterCubit(contactRepository: context.read()),
                child: const ContactRegisterCubitPage(),
              ),
          '/contacts-cubit/update': (context) {
            final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactRegisterCubit(contactRepository: context.read()),
              child: ContactUpdateCubitPage(
                contact: contact,
              ),
            );
          },
        },
      ),
    );
  }
}
