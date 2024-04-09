import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_repository.dart';

class DetaySayfaCubit extends Cubit<void>{

  DetaySayfaCubit():super(0);

  var trepo = TodoRepository();

  Future<void> guncelle(int id,String gorev) async{
    await trepo.guncelle1(id, gorev);
  }
}