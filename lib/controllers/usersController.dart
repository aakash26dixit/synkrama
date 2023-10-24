import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/usersModel.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  static var isLoading = false.obs;
  static var users = UsersModel().obs;
  static List<Datum> usersDatum = <Datum>[].obs;

  Future<void> fetchUsers() async {
    var requestJson = {};
    isLoading(true);
    http.Response response =
        await http.get(Uri.parse("https://reqres.in/api/users%E2%80%9D"));

    var responses = response.body.toString();
    try {
      usersDatum.clear();
      users.value = usersModelFromJson(responses);

      usersDatum.addAll(users.value.data!);
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return;
  }
}
