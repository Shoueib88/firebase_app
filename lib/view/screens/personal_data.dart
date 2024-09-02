import 'package:flutter/material.dart';

import 'controller/controller.dart';
import '../widgets/default_text.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) {
    final controller = Controller();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future(() => controller.getPersonalData()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: ListView.separated(
              itemCount: controller.listofpersonaldata.length,
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

                        controller.listofpersonaldata[index]['Image'] == null
                            ? Container(
                                width: 60, height: 60, color: Colors.red)
                            : Image.network(
                                controller.listofpersonaldata[index]['Image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                        DefaultText(
                            text:
                                'Name : ${controller.listofpersonaldata[index]['Name'] ?? ''}'),
                        DefaultText(
                            text:
                                'Age : ${controller.listofpersonaldata[index]['Age'] ?? ''}'),
                        DefaultText(
                            text:
                                'Address : ${controller.listofpersonaldata[index]['Address'] ?? ''}'),
                        DefaultText(
                            text:
                                'Phone : ${controller.listofpersonaldata[index]['Phone'] ?? ''}'),
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
