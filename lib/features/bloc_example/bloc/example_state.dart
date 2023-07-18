part of 'example_bloc.dart';

@immutable
abstract class ExampleState {}

class ExampleInitial extends ExampleState {}

class ExampleData extends ExampleState {
  final List<String> names;

  ExampleData({
    required this.names,
  });
}
