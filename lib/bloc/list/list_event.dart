part of 'list_bloc.dart';

abstract class ListEvent {
  const ListEvent();
}

class GetList extends ListEvent {
  final int page;
  final bool firstData;

  GetList(this.page, this.firstData);
}