class ProductDimensions {
  final double width;
  final double height;
  final double depth;

  ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      width: json['width'],
      height: json['height'],
      depth: json['depth'],
    );
  }
}

class ProductReview {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: json['rating'],
      comment: json['comment'] ?? '',
      date: json['date'],
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }
}

class ProductMeta {
  final String createdAt;
  final String updatedAt;
  final String barCode;
  final String qrCode;

  ProductMeta({
    required this.createdAt,
    required this.updatedAt,
    required this.barCode,
    required this.qrCode,
  });

  factory ProductMeta.fromJson(Map<String, dynamic> json) {
    return ProductMeta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barCode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final ProductDimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ProductReview> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final ProductMeta meta;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var meta = json['meta'];
    var reviews = json['reviews'] as List? ?? [];
    var dimensions = json['dimensions'];
    var tags = List<String>.from(json['tags']);
    var images = List<String>.from(json['images']);

    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      tags: tags,
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: json['weight'],
      dimensions: ProductDimensions.fromJson(dimensions),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: reviews.map((review) => ProductReview.fromJson(review)).toList(),
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: ProductMeta.fromJson(meta),
      thumbnail: json['thumbnail'],
      images: images,
    );
  }
}

class Productlistmodel {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  Productlistmodel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Productlistmodel.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List? ?? [];
    return Productlistmodel(
      products: productList
          .map((product) => Product.fromJson(product))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
