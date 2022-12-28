import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gms_and/widget_tree.dart';
import 'package:gms_and/widgets/user/qr.dart';
import 'package:gms_and/widgets/home_page.dart';
import 'package:provider/provider.dart';
import 'package:gms_and/models/notes_operation.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesOperation>(
      create: (context) => NotesOperation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        //initialRoute: '/',
        routes: {
          WidgetTree.routeName: (context) => const WidgetTree(),
        },
        home: const WidgetTree(),
      ),
    );
  }
}
