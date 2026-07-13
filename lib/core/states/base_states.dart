import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitialState<T> extends BaseState<T> {}

class LoadingState<T> extends BaseState<T> {}

class SuccessState<T> extends BaseState<T> {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends BaseState<T> {
  final String? message;

  const ErrorState([this.message]);

  @override
  List<Object?> get props => [message];
}
