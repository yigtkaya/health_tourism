class Package {
  final String packageName;
  final double price;
  final String packageDescription;
  final List<dynamic> packageFeatures;

  Package({
    required this.packageName,
    required this.price,
    required this.packageDescription,
    required this.packageFeatures,
  });

  List<Object> get props => [
        packageName,
        price,
    packageDescription,
        packageFeatures,
      ];

  bool get stringify => true;

  Package.fromData(Map<dynamic, dynamic> data)
      : packageName = data['packageName'],
        packageDescription = data['packageDescription'],
        price = data['packagePrice'].toDouble(),
        packageFeatures = data['packageFeatures'];

}