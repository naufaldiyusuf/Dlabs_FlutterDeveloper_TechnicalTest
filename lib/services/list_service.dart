part of 'services.dart';

class ListService {
  Future<ListModel> getListMovie(int page) async {
    var dio = Dio();

    final response = await dio.get(
        "https://dlabs-test.irufano.com/api/movie",
      queryParameters: {
          "size": 10,
        "page": page
      }
    );

    return ListModel.fromJson(response.data);
  }
}