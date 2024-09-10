import 'package:flutter/material.dart';
import 'package:my_notes/data/models/note_list_model.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';

class NoteListTile extends StatelessWidget {

  const NoteListTile({
    super.key,
    required this.data,
  });

  final TaskData data;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Card(
          elevation: 1,
              child:Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(data.title ?? 'Unknown',style: Head6Text(colorDarkBlue,),),
                     Text(data.description ?? '',style: Head7Text(colorLightGray),),
                  ],
                ),
              )
      ),
    );
  }
}