
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_integration/api/baapcontroller.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    BaapController baapController = Get.put(BaapController());
    // ignore: unused_local_variable
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      floatingActionButton:  IconButton(
            style: IconButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
            onPressed: () {
              Get.defaultDialog(
                title: "Add New User",
                content: addUser(),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            )),
    
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Getx Api integration",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
            itemBuilder: (context, BuildContext) {
              // ignore: invalid_use_of_protected_member
              return Obx(() => baapController.isLoading.value
                  ? const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: baapController.baapList
                          .map((e) => ListTile(
                                leading:
                                    const Icon(CupertinoIcons.profile_circled),
                                subtitle: Text(e.qualification.toString()),
                                title: Text(e.name.toString()),
                                trailing: Wrap(
                                  spacing: 12,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.defaultDialog(
                                            title: " Edit ",
                                            content: editUser(e.id),
                                          );
                                        },
                                        child: const Icon(Icons.edit)),
                                    InkWell(
                                        onTap: () {
                                          baapController.deleteApi(e.id);
                                        },
                                        child: const Icon(Icons.delete)),
                                  ],
                                ),
                              ))
                          .toList(),
                    ));
            },
            itemCount: 1,
          )),
        ],
      ),
    );
  }

  addUser() {
    BaapController baapController = Get.put(BaapController());
    TextEditingController textEditingController1 = TextEditingController();
    TextEditingController textEditingController2 = TextEditingController();
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "upload image",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.grey),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textEditingController1,
            decoration: const InputDecoration(labelText: "Name *"),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textEditingController2,
            decoration: const InputDecoration(labelText: "Your Qualification"),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            baapController.postTodos(
                textEditingController1.text, textEditingController2.text);

            Get.back();
            textEditingController1.clear();
            textEditingController2.clear();
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }

  editUser(id) {
    BaapController baapController = Get.put(BaapController());
    TextEditingController textEditingController1 = TextEditingController();
    TextEditingController textEditingController2 = TextEditingController();
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "upload image",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.grey),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textEditingController1,
            decoration: const InputDecoration(labelText: "Name *"),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textEditingController2,
            decoration: const InputDecoration(labelText: "Your Qualification"),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            baapController.updateDataById(
                id, textEditingController1.text, textEditingController2.text);
            Get.back();
            textEditingController1.clear();
            textEditingController2.clear();
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
