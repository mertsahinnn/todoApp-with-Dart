import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:todo_app/ui/views/anasayfa.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {

  var tfToDo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        title: const Text("Kayit Sayfa", style: TextStyle(color: tdBlack,fontSize: 30)),
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
                  context.read<KayitSayfaCubit>().kaydet(tfToDo.text);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("KAYDET"))
          ],
        ),
      ),
    );
  }
}
