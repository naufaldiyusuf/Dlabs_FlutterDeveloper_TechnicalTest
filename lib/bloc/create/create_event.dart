part of 'create_bloc.dart';

abstract class CreateEvent {
  const CreateEvent();
}

class CreateNewMovies extends CreateEvent {
  final String title;
  final String description;
  final File? poster;

  CreateNewMovies(this.title, this.description, this.poster);
}