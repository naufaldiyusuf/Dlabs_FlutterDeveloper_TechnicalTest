import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dlabs_dlutterdeveloper_technical_test/services/services.dart';

import '../../model/models.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc(CreateInitial createInitial) : super(CreateInitial()) {
    on<CreateEvent>((event, emit) async {
      if (event is CreateNewMovies) {
        emit(CreateLoading());
        
        try {
          final response = await CreateService().createMovieService(event.title, event.description, event.poster);

          emit(CreateSuccess());
        } catch(e) {
          emit(CreateError(e.toString()));
        }
      }
    });
  }
}