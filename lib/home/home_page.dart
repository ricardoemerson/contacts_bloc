import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/bloc'),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Text('Bloc'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/freezed'),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Text('Freezed'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/contacts/list'),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Text('Contacts'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
