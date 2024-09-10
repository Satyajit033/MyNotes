import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/presentation/state_holders/add_new_note_controller.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';


class AddNewNoteScreen extends StatefulWidget {
  const AddNewNoteScreen({super.key});

  @override
  State<AddNewNoteScreen> createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add a New Note", style: Head1Text(colorDarkBlue)),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: AppInputDecoration("Title"),
                    cursorColor: colorDarkBlue,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    decoration: AppInputDecoration(
                      "Description",
                    ),
                    cursorColor: colorDarkBlue,
                    maxLines: 4,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<AddNewNoteController>(
                      builder: (addNewNoteController) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible:
                            addNewNoteController.adNewNoteInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(
                            color: colorDarkBlue,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            addNewNoteController
                                .addNewTask(_titleTEController.text.trim(),
                                    _descriptionTEController.text.trim())
                                .then((value) {
                              if (value) {
                                _titleTEController.clear();
                                _descriptionTEController.clear();
                               SuccessToast("Task added successfully");
                              } else {
                                ErrorToast("Task add failed!");
                              }
                            });
                          },
                          style: AppButtonStyle(),
                          child: SuccessButtonChild(const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: colorDarkBlue,
                          )),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
