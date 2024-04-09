import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_repository.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);

  var trepo = TodoRepository();

  Future<void> kaydet(String name) async{
    await trepo.kaydet(name);
  }
}