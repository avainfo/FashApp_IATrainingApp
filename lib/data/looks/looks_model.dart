class Look {
  final String id;
  final int bottomId;
  final int shoeId;
  final int topId;
  final int errors;
  final String gender;
  final LookImages images;
  final LookMetadata metadata;

  Look({
    required this.id,
    required this.bottomId,
    required this.shoeId,
    required this.topId,
    required this.errors,
    required this.gender,
    required this.images,
    required this.metadata,
  });

  factory Look.fromFirestore(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Look(
      id: doc.id,
      bottomId: data['bottom_id'],
      shoeId: data['shoe_id'],
      topId: data['top_id'],
      errors: data['errors'],
      gender: data['gender'],
      images: LookImages.fromMap(data['images']),
      metadata: LookMetadata.fromMap(data['metadata']),
    );
  }
}

class LookImages {
  final String bottomUrl;
  final String topUrl;
  final String shoeUrl;

  LookImages({required this.bottomUrl, required this.topUrl, required this.shoeUrl});

  factory LookImages.fromMap(Map<String, dynamic> map) {
    return LookImages(
      bottomUrl: map['bottom_url'],
      topUrl: map['top_url'],
      shoeUrl: map['shoe_url'],
    );
  }
}

class LookMetadata {
  final Map<String, dynamic> top;
  final Map<String, dynamic> bottom;
  final Map<String, dynamic> shoe;

  LookMetadata({required this.top, required this.bottom, required this.shoe});

  factory LookMetadata.fromMap(Map<String, dynamic> map) {
    return LookMetadata(
      top: Map<String, dynamic>.from(map['top']),
      bottom: Map<String, dynamic>.from(map['bottom']),
      shoe: Map<String, dynamic>.from(map['shoe']),
    );
  }
}
