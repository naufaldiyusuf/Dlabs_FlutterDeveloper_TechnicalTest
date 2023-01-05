part of 'services.dart';

class CreateService {
  Future<CreateModel> createMovieService(String title, String description, File? poster) async {
    var dio = Dio();



    FormData formData = FormData.fromMap({
      "poster": poster == null ? null : await MultipartFile.fromFile(poster.path),
      "description": description,
      "title": title
    });

    final response = await dio.post(
        "https://dlabs-test.irufano.com/api/movie",
        data: formData
    );

    return CreateModel.fromJson(response.data);
  }
}