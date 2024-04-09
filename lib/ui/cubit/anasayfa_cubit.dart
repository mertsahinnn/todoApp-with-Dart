import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/toDos.dart';
import 'package:todo_app/data/repo/todo_repository.dart';

class AnasayfaCubit extends Cubit<List<ToDos>>{

  AnasayfaCubit():super(<ToDos>[]);

  var trepo = TodoRepository();

  Future<void> todoYukle() async{
    var liste = await trepo.toDosYukle();
    emit(liste);
  }

  Future<void> tosil(int id) async{
    await trepo.sil(id);
    await trepo.toDosYukle();
  }

  Future<void> arama(String aramaKelime) async{
    var liste = await trepo.arama(aramaKelime);
    emit(liste);
  }

  Future<void> guncellet(int id, int isDone) async{
    await trepo.guncelle(id, isDone);

  }
}