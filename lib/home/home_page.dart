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
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            runSpacing: 4,
            spacing: 4,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/bloc'),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width * .3,
                  ),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text(
                        'Bloc',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/freezed'),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width * .3,
                  ),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text(
                        'Freezed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/contacts/list'),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width * .3,
                  ),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text(
                        'Contacts',
                        textAlign: TextAlign.center,
                      ),
                    ),
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
