part of 'create_bloc.dart';

abstract class CreateState {
  const CreateState();
}

class CreateInitial extends CreateState {}

class CreateSuccess extends CreateState {}

class CreateError extends CreateState {
  final String errorMessage;

  CreateError(this.errorMessage);
}

class CreateLoading extends CreateState {}