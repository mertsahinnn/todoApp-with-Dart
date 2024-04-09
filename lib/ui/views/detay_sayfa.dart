import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  int id;
  String gorev;
  DetaySayfa(this.id, this.gorev);

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {

  var tfToDo = TextEditingController();


  @override
  Widget build(BuildContext context) {
    tfToDo.text = widget.gorev;
    print(widget.id);
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        title: const Text("Detay Sayfa", style: TextStyle(color: tdBlack,fontSize: 30)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: tfToDo,
                    decoration: const InputDecoration(hintText: "Gorev giriniz : "),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<DetaySayfaCubit>().guncelle(widget.id,tfToDo.text);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("GUNCELLE"))
          ],
        ),
      ),
    );
  }
}
