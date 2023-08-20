class Package {
  final String packageName;
  final double price;
  final List<dynamic> packageFeatures;

  Package({
    required this.packageName,
    required this.price,
    required this.packageFeatures,
  });

  List<Object> get props => [
        packageName,
        price,
        packageFeatures,
      ];

  bool get stringify => true;

  Package.fromData(Map<dynamic, dynamic> data)
      : packageName = data['packageName'],
        price = data['packagePrice'].toDouble(),
        packageFeatures = data['packageFeatures'];

}