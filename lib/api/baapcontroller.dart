import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_api_integration/model/baaapModel.dart';
import 'package:http/http.dart' as http;

class BaapController extends GetxController {
  var baapList = RxList<BaapModel>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

//get api
  Future<RxList<BaapModel>> getTodos() async {
    isLoading.value = true;
    final response = await http.get(Uri.parse(
        "https://655c6b6b25b76d9884fd327a.mockapi.io/api/Baapstudentapp"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        baapList.add(BaapModel.fromJson(index));
      }
      isLoading.value = false;
      return baapList;
    } else {
      return baapList;
    }
  }

  //post api

  Future<void> postTodos(name, qualification) async {
    isLoading.value = true;
    final response = await http.post(
        Uri.parse(
            "https://655c6b6b25b76d9884fd327a.mockapi.io/api/Baapstudentapp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "Name": name,
          "Qualification": qualification,
        }));
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("update Successfully");
      baapList.clear();
      getTodos();
      isLoading.value = false;
    } else {
      // ignore: avoid_print
      print("Record did't update");
    }
  }


  //put api

 Future<void> updateDataById(String id, String newName, String newQualification) async {
  isLoading.value = true;

  final response = await http.put(
    Uri.parse("https://655c6b6b25b76d9884fd327a.mockapi.io/api/Baapstudentapp/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'Name': newName,
      'Qualification': newQualification,
    }),
  );

  if (response.statusCode == 200) {
    // Successful update
    final updatedResource = BaapModel.fromJson(jsonDecode(response.body.toString()));
    int index = baapList.indexWhere((element) => element.id == id);
    if (index != -1) {
      baapList[index] = updatedResource;
    }
    isLoading.value = false;
  } else {
    // Handle errors, show an error message, etc.
    isLoading.value = false;
  }
}

  //delete api
  Future<void> deleteApi(id) async {
    isLoading.value = true;
    final response = await http.delete(Uri.parse(
        "https://655c6b6b25b76d9884fd327a.mockapi.io/api/Baapstudentapp/$id"));

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("update Successfully");
      baapList.clear();
      getTodos();
      isLoading.value = false;
    } else {
      // ignore: avoid_print
      print("Record did't update");
    }
  }
}
