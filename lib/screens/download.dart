import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

enum AudioType { ringtone, notification, alarm }

Future<void> downloadAndSetAudio({
  required BuildContext context,
  required String downloadUrl,
  required String filename,
  required AudioType type,
}) async {
  const platform = MethodChannel('custom.ringtone/set');

  try {
    // Ask required permissions
    final status = await [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.systemAlertWindow,
    ].request();

    if (status[Permission.manageExternalStorage]!.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Storage permission denied.")),
      );
      return;
    }

    final directory = Directory('/storage/emulated/0/Ringtones');
    if (!await directory.exists()) await directory.create(recursive: true);

    final filePath = p.join(directory.path, filename);
    final file = File(filePath);

    if (!await file.exists()) {
      final dio = Dio();
      await dio.download(downloadUrl, filePath);
      print('✅ Downloaded: $filePath');
    } else {
      print('📂 File already exists');
    }

    String typeString = type.name; // ringtone / notification / alarm

    await platform.invokeMethod('setTone', {
      'path': filePath,
      'type': typeString,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("🎉 ${type.name.capitalize()} set successfully!")),
    );
  } catch (e) {
    print('❌ Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("❌ Failed to set tone")),
    );
  }
}

extension StringCap on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
