import 'dart:async';

import 'package:todo_app/data/entity/toDos.dart';

import '../../sqlite/veritabani_yardimcisi.dart';

class TodoRepository{

  Future<List<ToDos>> toDosYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM toDos ORDER BY id DESC");

    return List.generate(maps.length, (index) {
      var satir = maps[index];

      if(satir["isDone"] is int){
        print("${satir["isDone"]} :  int");

      }else{
        print("${satir["isDone"]} : int degil");
      }
      return ToDos(id: satir["id"], name: satir["name"], isDone: satir["isDone"]);
    },);
  }

  Future<void> kaydet(String name) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniKisi = Map<String, dynamic>();
    yeniKisi["name"] = name;
    yeniKisi["isDone"] = 0;
    await db.insert("toDos", yeniKisi);
  }

  Future<void> sil(int id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("toDos", where: "id = ?", whereArgs: [id]);
  }

  Future<List<ToDos>> arama(String aramaKelime) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM toDos WHERE name like '%$aramaKelime%'");


    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return ToDos(id: satir["id"], name: satir["name"], isDone: satir["isDone"]);
    },);
  }

  Future<void> guncelle(int id, int isDone) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenentodo = <String, dynamic>{};
    if(isDone == 1){
      guncellenentodo["isDone"] = 0;
    }else{
      guncellenentodo["isDone"] = 1;
    }
    await db.update("toDos", guncellenentodo, where: "id = ?" , whereArgs: [id]);
  }

  Future<void> guncelle1(int id, String gorev) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenentodo = <String, dynamic>{};
    guncellenentodo["name"] = gorev;
    await db.update("toDos", guncellenentodo, where: "id = ?" , whereArgs: [id]);
  }
}