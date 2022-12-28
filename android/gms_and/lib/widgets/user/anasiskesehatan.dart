import 'package:flutter/material.dart';
import 'package:gms_and/models/transaction.dart';
import 'package:gms_and/widgets/user/new_transaction.dart';
import 'package:gms_and/widgets/chart.dart';

import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* import model */
import 'package:gms_and/models/glucose_data.dart';
import 'package:gms_and/models/glucose_list.dart';
import 'package:gms_and/auth.dart';

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

final User? user = Auth().currentUser;
Future<String> fetchGlucose() async {
  final response = await http.get(
      Uri.parse('https://www.simpade.com:4646/getdata?user=${user?.email}'));
  if (response.statusCode == 200) {
    print(response.body.runtimeType.toString());
    return response.body.toString();
  } else {
    throw Exception('Failed to load glucose data');
  }
}

class AnaKes extends StatefulWidget {
  const AnaKes({super.key});

  @override
  State<AnaKes> createState() => _AnaKesState();
}

class _AnaKesState extends State<AnaKes> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),

    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  late Future<Album> futureAlbum;
  // late Future<GlucoseList> futureGlucoseList;
  late Future<String> futureGlucose;

  @override
  void initState() {
    super.initState();
    futureGlucose = fetchGlucose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Text("7 status glucose anda terakhir"),
        //Chart(_recentTransactions),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
          ),
          child: SizedBox(
            height: 200,
            child: FutureBuilder<String>(
              future: futureGlucose,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      //padding: const EdgeInsets.all(8),
                      itemCount: jsonDecode(snapshot.data!)["data"].length,
                      itemBuilder: (BuildContext context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              child: Text(
                                jsonDecode(snapshot.data!)["data"][
                                    jsonDecode(snapshot.data!)["data"].length -
                                        index -
                                        1]["tenant"],
                              ),
                            ),

                            Card(
                              child: Text(jsonDecode(snapshot.data!)["data"][
                                  jsonDecode(snapshot.data!)["data"].length -
                                      index -
                                      1]["date_time"]),
                            ),
                            Card(
                              child: Text(jsonDecode(snapshot.data!)["data"][
                                      jsonDecode(snapshot.data!)["data"]
                                              .length -
                                          index -
                                          1]["glucose_level"]
                                  .toString()),
                            ),
                            //Card(child: Text(snapshot.data!.length.toString())),
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text(' gak ada data ${snapshot.error}');
                }

                return const CircularProgressIndicator();
              }),
            ),
          ),
        ),
      ],
    );
  }
}
