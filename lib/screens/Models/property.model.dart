
class PropertyModel {
  final String id; // uuid is typically represented as a String in Dart
  final String ownerId;
  final String location;
  final double price; // Using double for numeric, assuming it can have decimal values
  final String imageUrl;
  final String description;
  final bool isAvailable;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final double sizeSqft; // Using double for numeric
  final DateTime createdAt; // Using DateTime for timestamp
  final DateTime updatedAt; // Using DateTime for timestamp

  PropertyModel({
    required this.id,
    required this.ownerId,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.isAvailable,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.sizeSqft,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new PropertyModel instance from a map
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      location: json['location'] as String,
      price: (json['price'] as num).toDouble(),
      // Ensure conversion from num to double
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
      isAvailable: json['is_available'] as bool,
      propertyType: json['property_type'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      sizeSqft: (json['size_sqft'] as num).toDouble(),
      // Ensure conversion from num to double
      createdAt: DateTime.parse(json['created_at'] as String),
      // Parse string to DateTime
      updatedAt: DateTime.parse(
          json['updated_at'] as String), // Parse string to DateTime
    );
  }

  // Method for converting a PropertyModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'location': location,
      'price': price,
      'image_url': imageUrl,
      'description': description,
      'is_available': isAvailable,
      'property_type': propertyType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'size_sqft': sizeSqft,
      'created_at': createdAt.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'updated_at': updatedAt.toIso8601String(),
      // Convert DateTime to ISO 8601 string
    };
  }
}