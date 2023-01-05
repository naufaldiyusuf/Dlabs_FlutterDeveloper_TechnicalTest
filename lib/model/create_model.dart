part of 'models.dart';

class CreateModel {
  String status = "";
  String? data;

  CreateModel({
    required this.status,
    this.data
  });

  CreateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }
}