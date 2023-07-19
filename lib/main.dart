import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/bloc_example/bloc/example_bloc.dart';
import 'features/bloc_example/bloc_example_page.dart';
import 'features/contacts/contacts_list/bloc/contact_list_bloc.dart';
import 'features/contacts/contacts_list/contacts_list_page.dart';
import 'features/freezed_example/bloc/freezed_bloc.dart';
import 'features/freezed_example/freezed_example_page.dart';
import 'home/home_page.dart';
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
                create: (context) => ContactListBloc(repository: context.read<ContactRepository>())
                  ..add(const ContactListEvent.findAll()),
                child: const ContactsListPage(),
              ),
        },
      ),
    );
  }
}
