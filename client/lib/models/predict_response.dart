class DaysResponse {
  final double days;

  DaysResponse({required this.days});

  // Factory constructor to create an instance from JSON
  factory DaysResponse.fromJson(Map<String, dynamic> json) {
    return DaysResponse(
      days: json['days']?.toDouble() ?? 0.0,
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'days': days,
    };
  }
}
