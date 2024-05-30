
// To parse this JSON data, do
//
//     final geminiTalkRes = geminiTalkResFromJson(jsonString);

import 'dart:convert';

GeminiTalkRes geminiTalkResFromJson(String str) => GeminiTalkRes.fromJson(json.decode(str));

String geminiTalkResToJson(GeminiTalkRes data) => json.encode(data.toJson());

class GeminiTalkRes {
  List<Candidate> candidates;
  UsageMetadata usageMetadata;

  GeminiTalkRes({
    required this.candidates,
    required this.usageMetadata,
  });

  factory GeminiTalkRes.fromJson(Map<String, dynamic> json) => GeminiTalkRes(
    candidates: List<Candidate>.from(json["candidates"].map((x) => Candidate.fromJson(x))),
    usageMetadata: UsageMetadata.fromJson(json["usageMetadata"]),
  );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
    "usageMetadata": usageMetadata.toJson(),
  };
}

class Candidate {
  Content content;
  String finishReason;
  int index;
  List<SafetyRating> safetyRatings;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.index,
    required this.safetyRatings,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    content: Content.fromJson(json["content"]),
    finishReason: json["finishReason"],
    index: json["index"],
    safetyRatings: List<SafetyRating>.from(json["safetyRatings"].map((x) => SafetyRating.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": content.toJson(),
    "finishReason": finishReason,
    "index": index,
    "safetyRatings": List<dynamic>.from(safetyRatings.map((x) => x.toJson())),
  };
}

class Content {
  List<Part> parts;
  String role;

  Content({
    required this.parts,
    required this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
    "role": role,
  };
}

class Part {
  String text;

  Part({
    required this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class SafetyRating {
  String category;
  String probability;

  SafetyRating({
    required this.category,
    required this.probability,
  });

  factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
    category: json["category"],
    probability: json["probability"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "probability": probability,
  };
}

class UsageMetadata {
  int promptTokenCount;
  int candidatesTokenCount;
  int totalTokenCount;

  UsageMetadata({
    required this.promptTokenCount,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) => UsageMetadata(
    promptTokenCount: json["promptTokenCount"],
    candidatesTokenCount: json["candidatesTokenCount"],
    totalTokenCount: json["totalTokenCount"],
  );

  Map<String, dynamic> toJson() => {
    "promptTokenCount": promptTokenCount,
    "candidatesTokenCount": candidatesTokenCount,
    "totalTokenCount": totalTokenCount,
  };
}
