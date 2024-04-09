import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class VeritabaniYardimcisi{

  static final String veritabaniAdi = "todo_app1.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniAdi);

    if (await databaseExists(veritabaniYolu)){
      print("Veritabani zaten var. Kopyalamaya gerek yok");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush : true);
      print("Veritabani Kopyalandi");
    }
    return openDatabase(veritabaniYolu);
  }
}