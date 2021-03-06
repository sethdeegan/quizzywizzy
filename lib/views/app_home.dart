import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Router
import 'package:quizzywizzy/services/router.dart';
import 'package:quizzywizzy/views/loading.dart';

/// Widgets
import 'package:quizzywizzy/widgets/body_template.dart';
import 'package:quizzywizzy/widgets/selection_cell.dart';
import 'package:transparent_image/transparent_image.dart';

class AppHomeView extends StatelessWidget {
  final AppRouterDelegate delegate = Get.find<AppRouterDelegate>();
  final CollectionReference? collection;

  AppHomeView({required this.collection});

  Widget build(BuildContext context) {
    return BodyTemplate(
        child: FutureBuilder<QuerySnapshot>(
            future: collection!.get(/* GetOptions(source: Source.cache)*/),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // If error
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              // Snapshot retreived so render
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data!.docs);
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                        child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text(collection!.id.capitalize!,
                          style: TextStyle(
                            fontSize: 40,
                          )),
                    )),
                    SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        alignment: WrapAlignment.center,
                        children: snapshot.data!.docs
                            .map((docSnapshot) {
                              Map doc = docSnapshot.data() as Map<dynamic, dynamic>;
                              return SelectionCell(
                                  image: Icon(Icons.ac_unit),
                                  text: doc["name"],
                                  type: doc.containsKey("questions")
                                      ? (doc["questions"] ? 0 : 1)
                                      : 2,
                                  onTap: () => delegate.push(doc["url"]));
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                    ),
                  ],
                );
              }
              return LoadingView();
            }));
  }
}
