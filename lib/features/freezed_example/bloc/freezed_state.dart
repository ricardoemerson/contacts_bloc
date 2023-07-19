part of 'freezed_bloc.dart';

@freezed
class FreezedState with _$FreezedState {
  const factory FreezedState.initial() = _FreezedInitial;
  const factory FreezedState.loading() = _FreezedLoading;
  const factory FreezedState.showBanner({
    required List<String> names,
    required String message,
  }) = _FreezedShowBanner;
  const factory FreezedState.data({required List<String> names}) = _FreezedData;
}
