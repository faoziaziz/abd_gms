import 'package:flutter/widgets.dart';

class Buku {
  final String title;
  final String penulis;
  final int tahun_terbit;

  Buku({
    required this.title,
    required this.penulis,
    required this.tahun_terbit,
  });

  Buku.fromJson(Map<String, Object> json)
      : this(
          title: json["title"] as String,
          penulis: json["penulis"] as String,
          tahun_terbit: json["tahun_terbit"] as int,
        );

  Map<String, Object> toJson() {
    return {
      "title": this.title,
      "penulis": this.penulis,
      "tahun_terbit": this.tahun_terbit,
    };
  }
}
