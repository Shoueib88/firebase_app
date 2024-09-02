import 'package:firebase_app/view/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'controller/controller.dart';

class Detials extends StatefulWidget {
  const Detials({super.key});

  @override
  State<Detials> createState() => _DetialsState();
}

class _DetialsState extends State<Detials> {
  final controller = Controller();
  @override
  void initState() {
    // setState(() {
    //   controller.getData();
    // });
    print('welcome');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(text: 'Detials'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future(() => controller.getData()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: ListView.separated(
              itemCount: controller.listofdata.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 2);
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(15),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // fetch image

                        controller.listofdata[index]['Image'] == null
                            ? Container(
                                width: 60, height: 60, color: Colors.red)
                            : Image.network(
                                controller.listofdata[index]['Image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                        DefaultText(
                            text:
                                'Name : ${controller.listofdata[index]['Name'] ?? ''}'),
                        DefaultText(
                            text:
                                'Age : ${controller.listofdata[index]['Age'] ?? ''}'),
                        DefaultText(
                            text:
                                'Address : ${controller.listofdata[index]['Address'] ?? ''}'),
                        DefaultText(
                            text:
                                'Phone : ${controller.listofdata[index]['Phone'] ?? ''}'),
                      ],
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
