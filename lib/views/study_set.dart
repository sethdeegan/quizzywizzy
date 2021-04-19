import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzywizzy/services/router.dart';
import 'package:quizzywizzy/services/routing_constants.dart';
import 'package:quizzywizzy/widgets/body_template.dart';



class StudySetView extends StatelessWidget {
  final List<Map<String, dynamic>> questionsDocs;

  final AppRouterDelegate delegate = Get.find<AppRouterDelegate>();

  StudySetView({@required this.questionsDocs});

  /*
  FirebaseFirestore.instance
    .collection('questions')
    .where('age', isGreaterThan: 20)
    .get()
    .then(...);
  */

  Widget build(BuildContext context) {
    return BodyTemplate(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Text(questionsDocs[index]["name"]);
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => delegate.pushPseudo(PseudoPage.addQuestion),
              tooltip: 'Add Question',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
