class FarmInfo {
  String businessName;
  String informalName;
  String streetAddress;
  String city;
  String state;
  int zipCode;

  FarmInfo({
    this.businessName = '',
    this.informalName = '',
    this.streetAddress = '',
    this.city = '',
    this.state = '',
    this.zipCode = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'informal_name': informalName,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'zip_code': zipCode,
    };
  }

  factory FarmInfo.fromJson(Map<String, dynamic> json) {
    return FarmInfo(
      businessName: json['business_name'] as String? ?? '',
      informalName: json['informal_name'] as String? ?? '',
      streetAddress: json['street_address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zipCode: json['zip_code'] as int? ?? 0,
    );
  }
}
