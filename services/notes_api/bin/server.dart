import 'package:notes_api/src/application/notes_api_host.dart';
export 'package:notes_api/src/application/notes_api_host.dart';

Future<void> main() async {
  await NotesApiHost().run();
}
