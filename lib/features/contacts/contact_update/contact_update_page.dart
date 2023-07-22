import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../models/contact_model.dart';
import '../../../widgets/loader.dart';
import 'bloc/contact_update_bloc.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contact;

  const ContactUpdatePage({
    super.key,
    required this.contact,
  });

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameEC.text = widget.contact.name;
    _emailEC.text = widget.contact.email;
  }

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
        title: const Text('ContactUpdatePage'),
        centerTitle: true,
      ),
      body: BlocListener<ContactUpdateBloc, ContactUpdateState>(
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
                      context.read<ContactUpdateBloc>().add(
                            ContactUpdateEvent.save(
                              id: widget.contact.id!,
                              name: _nameEC.text,
                              email: _emailEC.text,
                            ),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactUpdateBloc, ContactUpdateState>(
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
