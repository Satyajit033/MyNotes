import 'package:get/get.dart';
import 'package:my_notes/data/services/network_caller.dart';
import 'package:my_notes/data/models/network_response.dart';
import 'package:my_notes/data/utility/urls.dart';


class AddNewNoteController extends GetxController {
  bool _adNewNoteInProgress = false;

  bool get adNewNoteInProgress => _adNewNoteInProgress;

  Future<bool> addNewTask(String title, String description) async {
    _adNewNoteInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createNotes, requestBody);
    _adNewNoteInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}