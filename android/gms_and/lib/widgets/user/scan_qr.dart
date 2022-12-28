import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:gms_and/widgets/user/qr.dart';
import 'package:gms_and/widgets/home_page.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey();
  String barcode = "";
  double valGlucose = 12.0;
  bool _isDispGlucose = true;
  void _dispGlucose() {
    setState(() {
      _isDispGlucose = !_isDispGlucose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _dispGlucose(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 5.0, color: Colors.blue),
            ),
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QRViewExample(),
                          ));
                        },
                        child: const Text('qrView'),
                      ),
                    ),
                    Text("Halo"),
                  ],
                ),
              ),
            ),
          ),
        ),
        _isDispGlucose
            ? Text("Nilai Glukosa anda adalah $valGlucose")
            : Text(''),
      ],
    );
  }
}
