import 'package:gemini_app/data/models/message_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static var box = Hive.box("cards_db");

  static init() async {
    var appDocumentary = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentary.path)
      ..registerAdapter(MessageModelAdapter());
    await Hive.openBox("cards_db");
  }

  static saveMessage(MessageModel message) async {
    box.add(message);
  }

  static List<MessageModel> getMessages() {
    List<MessageModel> messages = [];
    for (var i = 0; i < box.length; i++) {
      messages.add(box.getAt(i));
    }
    return messages;
  }


}
