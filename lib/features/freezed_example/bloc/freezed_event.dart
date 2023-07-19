part of 'freezed_bloc.dart';

@freezed
class FreezedEvent with _$FreezedEvent {
  const factory FreezedEvent.findNames() = _FreezedFindNamesEvent;
  const factory FreezedEvent.addName(String name) = _FreezedAddNameEvent;
  const factory FreezedEvent.removeName(String name) = _FreezedRemoveNameEvent;
}
