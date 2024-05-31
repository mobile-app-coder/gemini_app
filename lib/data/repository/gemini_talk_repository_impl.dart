import 'package:gemini_app/core/services/log_service.dart';
import 'package:gemini_app/domain/repositories/gemini_talk_repository.dart';

import '../datasources/remote/https_service.dart';

class GeminiTalkRepositoryImpl extends GeminiTalkRepository {
  @override
  Future<String> onTextOnly(String text) async {
    var response = await Network.POST(
        Network.API_GEMINI_TALK, Network.paramsTextOnly(text));
    var geminiTalk = Network.parseGeminiTalk(response!);
    var result = geminiTalk.candidates[0].content.parts[0].text;
    return result;
  }

  @override
  Future<String> onAndImage(String text, String base64) async {
    LogService.i(base64);
    var response = await Network.POST(
        Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64));
    var geminiTalk = Network.parseGeminiTalk(response!);
    var result = geminiTalk.candidates[0].content.parts[0].text;
    return result;
  }
}
