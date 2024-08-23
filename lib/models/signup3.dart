class Verification {
  String? fileName;

  Verification({this.fileName});

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
    };
  }

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      fileName: json['file_name'] as String?,
    );
  }
}
