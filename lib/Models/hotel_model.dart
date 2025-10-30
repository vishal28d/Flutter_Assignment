

class Hotel {
  final String? name;
  final String? city;
  final String? country;
  final String? price;
  final String? image;

  Hotel({this.name, this.city, this.country, this.price, this.image});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['entity_name'] ?? json['hotelName'] ?? 'Unknown',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      price: json['price']?.toString(),
      image: (json['images'] is List && json['images'].isNotEmpty)
          ? json['images'][0]
          : '',
    );
  }
}
