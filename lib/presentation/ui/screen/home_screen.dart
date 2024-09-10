import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/presentation/ui/screen/add_new_note_screen.dart';
import 'package:my_notes/data/utility/auth_utility.dart';
import 'package:my_notes/presentation/state_holders/get_notes_controller.dart';
import 'package:my_notes/presentation/ui/screen/auth/login_screen.dart';
import 'package:my_notes/presentation/ui/widget/home_drawer.dart';
import 'package:my_notes/presentation/ui/widget/note_list_tile.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';
import 'package:my_notes/data/utility/urls.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetNotesController _getNotesController = Get.find<GetNotesController>();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNotesController.getTasks(Urls.newNotes).then((value) {
        if (value == false) {
          ErrorToast("New note data get failed!");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes', style: Head4Text(colorDarkBlue)),
        elevation: 10,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () async {
                if (mounted) {
                  logoutAlertDialogue();
                }
              },
              icon: const Icon(
                Icons.logout,
                color: colorDarkBlue,
              )),
        ],
      ),
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: colorDarkBlue,
                onRefresh: () async {
                  _getNotesController.getTasks(Urls.newNotes).then((value) {
                    if (value == false) {
                      ErrorToast("New note data get failed!");
                    }
                  });
                },
                child: GetBuilder<GetNotesController>(
                    builder: (getNotesController) {
                  return getNotesController.getNotesInProgress
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: colorDarkBlue,
                          ),
                        )
                      : ListView.separated(
                          itemCount:
                              getNotesController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return NoteListTile(
                              data: getNotesController.taskListModel.data![index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: colorDarkBlue,
        ),
        onPressed: () {
          Get.to(const AddNewNoteScreen());
        },
      ),
    );
  }

  void logoutAlertDialogue() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Logout Alert',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Do you want to log out?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'No',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              AuthUtility.clearUserInfo();
              Get.offAll(() => const LoginScreen());
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

