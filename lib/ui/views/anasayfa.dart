import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/data/entity/toDos.dart';
import 'package:todo_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todo_app/ui/views/detay_sayfa.dart';
import 'package:todo_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyormu = false;
  var tfController = TextEditingController();

  @override
  void initState() {
    context.read<AnasayfaCubit>().todoYukle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyormu ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Arama"
                ),
                controller: tfController,
                onChanged: (value) {
                  context.read<AnasayfaCubit>().arama(value);
                },
              ),
            )
            :
        const Text(
          "All ToDos",
          style: TextStyle(fontSize: 30, color: tdBlack),
        ),
        actions: [
          aramaYapiliyormu ?
          Container(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    aramaYapiliyormu = false;
                  });
                  tfController.text = "";
                  context.read<AnasayfaCubit>().todoYukle();
                },
                icon: const Icon(Icons.clear)),
          )
              :
          Container(
            height: 50,
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.search_outlined)
              ,onPressed: () {
                setState(() {
                  aramaYapiliyormu = true;
                });

            },),
          ),
        ],
        backgroundColor: tdBGColor,
      ),
      body: BlocBuilder<AnasayfaCubit,List<ToDos>>(
        builder: (context, todoList) {
          if(todoList.isNotEmpty){
            return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  var todo = todoList[index];
                  bool tfcheck;
                  if(todo.isDone == 1){
                    tfcheck = true;
                  }else{
                    tfcheck = false;
                  }
                  return SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  print("check basildi");
                                  setState(() {
                                    context.read<AnasayfaCubit>().guncellet(todo.id, todo.isDone);
                                    if(todo.isDone == 1){
                                      tfcheck = true;
                                    }else{
                                      tfcheck = false;
                                    }
                                    context.read<AnasayfaCubit>().todoYukle();
                                  });

                                },
                                icon: tfcheck? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank)),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(todo.id, todo.name),)).then((value) {
                                  context.read<AnasayfaCubit>().todoYukle();
                                });
                              },
                              child: Text(todo.name, style: TextStyle(
                                color: tdBlack,
                                fontSize: 18,
                                decoration: tfcheck? TextDecoration.lineThrough : null
                              )),
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              padding: const EdgeInsets.all(0),
                              margin: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: tdRed
                              ),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    print("delete basildi");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("${todo.name} silinsin mi?"),
                                            action: SnackBarAction(
                                                label: "Evet",
                                                onPressed: () {
                                                  print("${todo.name} silindi" );
                                                  context.read<AnasayfaCubit>().tosil(todo.id);
                                                  context.read<AnasayfaCubit>().todoYukle();
                                                },),
                                        )
                                    );
                                  },
                                  icon: Icon(Icons.delete, size: 18,)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
            );
          }else{
            return const Center();
          }
        },
      ),
      backgroundColor: tdBGColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KayitSayfa()))
            .then((value){
            context.read<AnasayfaCubit>().todoYukle();
          });
      },
        child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40),
        backgroundColor: tdBlue,
      ),

    );
  }
}
