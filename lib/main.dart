import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/bloc_example/bloc/example_bloc.dart';
import 'features/bloc_example/bloc_example_page.dart';
import 'features/contacts/contacts_list/contacts_list_page.dart';
import 'features/freezed_example/bloc/freezed_bloc.dart';
import 'features/freezed_example/freezed_example_page.dart';
import 'home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/contacts/list': (context) => const ContactsListPage(),
      },
    );
  }
}
