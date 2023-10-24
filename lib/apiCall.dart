import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synkrama/controllers/usersController.dart';

import 'controllers/addUsersController.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({Key? key}) : super(key: key);

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UsersController uc = Get.put(UsersController());
      await uc.fetchUsers();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Call"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          AddUsersController ad = Get.put(AddUsersController());
          UsersController uc = Get.put(UsersController());

          await ad.addUser();
          await uc.fetchUsers();
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        return UsersController.isLoading.value
            ? CircularProgressIndicator()
            : SingleChildScrollView(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // Number of items in the cross axis
                    mainAxisSpacing: 10.0,
                    // Space between the items along the main axis
                    crossAxisSpacing: 10.0,
                    // Space between the items along the cross axis
                    childAspectRatio:
                        1, // Ratio of the width to the height of each item
                  ),
                  itemCount: UsersController.usersDatum.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: Text(UsersController.usersDatum[index].name),
                          //       content: Column(
                          //         children: [
                          //           Text(UsersController.usersDatum[index].id.toString()),
                          //           Text(UsersController.usersDatum[index].name.toString()),
                          //           Text(UsersController.usersDatum[index].color.toString()),
                          //           Text(UsersController.usersDatum[index].pantoneValue.toString()),
                          //         ]
                          //       ),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: Text('Close'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Name: ${UsersController.usersDatum[index].name}",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "ID: ${UsersController.usersDatum[index].id.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w900)),

                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Pantone Value: ${UsersController.usersDatum[index].pantoneValue.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Color: ${UsersController.usersDatum[index].color.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                  child: Text("Close",
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight
                                                              .w900)))),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Color(int.parse(
                                        UsersController.usersDatum[index].color
                                            .replaceAll('#', ''),
                                        radix: 16))
                                    .withOpacity(1.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Text(
                                    UsersController.usersDatum[index].id
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 102.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Text(
                                  UsersController.usersDatum[index].name,
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            )));
                  }),
            );
      }),
    );
  }
}
