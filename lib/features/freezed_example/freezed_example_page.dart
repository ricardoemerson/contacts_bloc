import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/freezed_bloc.dart';

class FreezedExamplePage extends StatelessWidget {
  const FreezedExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FreezedBloc>().add(const FreezedEvent.addName('Novo item...'));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<FreezedBloc, FreezedState>(
        listener: (context, state) {
          state.whenOrNull(
            showBanner: (_, message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
          );
        },
        child: Column(
          children: [
            BlocSelector<FreezedBloc, FreezedState, bool>(
              selector: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            BlocSelector<FreezedBloc, FreezedState, List<String>>(
              selector: (state) {
                return state.maybeWhen(
                  data: (names) => names,
                  showBanner: (names, _) => names,
                  orElse: () => <String>[],
                );
              },
              builder: (context, names) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final name = names[index];

                    return ListTile(
                      onTap: () {
                        context.read<FreezedBloc>().add(FreezedEvent.removeName(name));
                      },
                      title: Text(name),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
