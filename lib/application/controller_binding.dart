import 'package:get/get.dart';
import 'package:my_notes/presentation/state_holders/add_new_note_controller.dart';
import 'package:my_notes/presentation/state_holders/get_notes_controller.dart';
import 'package:my_notes/presentation/state_holders/login_controller.dart';
import 'package:my_notes/presentation/state_holders/sign_up_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(AddNewNoteController());
    Get.put(GetNotesController());
  }
}