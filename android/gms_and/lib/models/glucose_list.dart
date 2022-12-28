//import './glucose_data.dart';

class GlucoseList {
  final int idTrans;
  final int glucoseValue;
  final String username;
  final String datetime;

  GlucoseList(
      {required this.idTrans,
      required this.glucoseValue,
      required this.username,
      required this.datetime});

  factory GlucoseList.fromJson(Map<String, dynamic> json) {
    return GlucoseList(
      idTrans: json["idtrans"],
      glucoseValue: json["glucose_level"],
      username: json["user"],
      datetime: json["datetime"],
    );
  }
}
