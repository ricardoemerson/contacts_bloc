import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../models/contact_model.dart';
import '../../../widgets/loader.dart';
import 'cubit/contact_register_cubit.dart';

class ContactRegisterCubitPage extends StatefulWidget {
  const ContactRegisterCubitPage({super.key});

  @override
  State<ContactRegisterCubitPage> createState() => _ContactRegisterCubitPageState();
}

class _ContactRegisterCubitPageState extends State<ContactRegisterCubitPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Register Cubit'),
        centerTitle: true,
      ),
      body: BlocListener<ContactRegisterCubit, ContactRegisterState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (_) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            success: () => Navigator.of(context).pop(),
            error: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  autofocus: true,
                  decoration: const InputDecoration(label: Text('Nome')),
                  validator: Validatorless.required('Nome é obrigatório.'),
                ),
                TextFormField(
                  controller: _emailEC,
                  autofocus: true,
                  decoration: const InputDecoration(label: Text('e-Mail')),
                  validator: Validatorless.multiple([
                    Validatorless.required('e-Mail é obrigatório.'),
                    Validatorless.email('e-Mail inválido.')
                  ]),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    final formIsValid = _formKey.currentState?.validate() ?? false;

                    if (formIsValid) {
                      final contact = ContactModel(
                        name: _nameEC.text,
                        email: _emailEC.text,
                      );

                      context.read<ContactRegisterCubit>().save(contact);
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactRegisterCubit, ContactRegisterState>(
                  selector: (state) {
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
