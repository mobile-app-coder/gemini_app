import '../repositories/gemini_talk_repository.dart';

class GeminiTextAndImageUseCase {
  GeminiTalkRepository repository;

  GeminiTextAndImageUseCase(this.repository);

  Future<String> call(String text, String base64) async {
    return await repository.onAndImage(text, base64);
  }
}
