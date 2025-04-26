import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String?> scanBarcode() async {
  try {
    final String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",  // Color of the scan line
      "Cancel",   // Cancel button text
      true,       // Show flash icon
      ScanMode.BARCODE,
    );

    if (barcodeScanRes != '-1') {
      return barcodeScanRes;
    }
  } catch (e) {
    // Handle any errors that might occur
    if (kDebugMode) {
      print("Error occurred while scanning barcode: $e");
    }
  }

  return null; // Return null if the scan was cancelled or failed
}
