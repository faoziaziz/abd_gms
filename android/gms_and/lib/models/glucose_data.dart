//import 'dart:convert';
///import './glucose_list.dart';

class GlucoseData {
  final int status;
  final List data;
  final String teks = "Glucose Data";
  const GlucoseData({
    required this.status,
    required this.data,
  });

  factory GlucoseData.fromJson(Map<String, dynamic> json) {
    return GlucoseData(
      status: json['status'],
      data: json["data"],
    );
  }
}
