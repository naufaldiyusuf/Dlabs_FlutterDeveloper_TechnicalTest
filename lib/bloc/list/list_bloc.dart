import 'package:bloc/bloc.dart';
import 'package:dlabs_dlutterdeveloper_technical_test/services/services.dart';

import '../../model/models.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(ListInitial listInitial) : super(ListInitial()) {
    on<ListEvent>((event, emit) async {
      if (event is GetList) {
        if (event.firstData) {
          emit(ListGetLoading());
        } else {
          emit(ListGetLoadingNext());
        }
        
        try {
          final response = await ListService().getListMovie(event.page);

          emit(ListGetSuccess(response.data));
        } catch(e) {
          if (event.firstData) {
            emit(ListGetError());
          } else {
            emit(ListGetNextError());
          }
        }
      }
    });
  }
}