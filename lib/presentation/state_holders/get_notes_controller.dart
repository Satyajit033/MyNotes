import 'package:get/get.dart';
import 'package:my_notes/data/services/network_caller.dart';
import 'package:my_notes/data/models/network_response.dart';
import 'package:my_notes/data/models/note_list_model.dart';


class GetNotesController extends GetxController {
  bool _getNotesInProgress = false;
  NoteListModel _taskListModel = NoteListModel();

  void getUpdateState() {
    update();
  }

  bool get getNotesInProgress => _getNotesInProgress;
  NoteListModel get taskListModel => _taskListModel;

  Future<bool> getTasks(String url) async {
    _getNotesInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(url);
    _getNotesInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = NoteListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      return false;
    }
  }
}

