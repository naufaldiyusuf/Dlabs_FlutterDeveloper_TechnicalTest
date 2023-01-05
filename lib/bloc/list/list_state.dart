part of 'list_bloc.dart';

abstract class ListState {
  const ListState();
}

class ListInitial extends ListState {}

class ListGetSuccess extends ListState {
  final List<ListModelData> data;

  ListGetSuccess(this.data);
}

class ListGetError extends ListState {}

class ListGetLoading extends ListState {}

class ListGetLoadingNext extends ListState {}

class ListGetNextError extends ListState {}