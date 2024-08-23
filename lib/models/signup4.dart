class BusinessHours {
  final Map<String, List<String>> hours;

  BusinessHours(this.hours);

  Map<String, dynamic> toJson() {
    return hours.map((key, value) => MapEntry(key, value));
  }
}
