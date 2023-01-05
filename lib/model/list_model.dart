part of 'models.dart';

class ListModel {
  String? status;
  List<ListModelData> data = [];

  ListModel({
    this.status
  });

  ListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((e) {
        data.add(ListModelData.fromJson(e));
      });
    }
  }
}

class ListModelData {
  int id = 0;
  String title = "";
  String description = "";
  String? poster;

  ListModelData({
    required this.id,
    required this.title,
    required this.description,
    this.poster
  });

  ListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    poster = json['poster'];
  }
}