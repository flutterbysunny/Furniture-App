// app/models/shipping_address_model.dart

class ShippingAddressModel {
  final String id;
  final String label;
  final String fullAddress;

  const ShippingAddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
  });
}

// ✅ Ek hi jagah — dono controllers import karke use karo
final sharedAddresses = <ShippingAddressModel>[
  const ShippingAddressModel(
    id: '1',
    label: 'Home',
    fullAddress: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
  ),
  const ShippingAddressModel(
    id: '2',
    label: 'Office',
    fullAddress: '4517 Washington Ave. Manchester, Kentucky 39495',
  ),
  const ShippingAddressModel(
    id: '3',
    label: "Parent's House",
    fullAddress: '8502 Preston Rd. Inglewood, Maine 98380',
  ),
  const ShippingAddressModel(
    id: '4',
    label: "Friend's House",
    fullAddress: '2464 Royal Ln. Mesa, New Jersey 45463',
  ),
];

class ShippingTypeModel {
  final String id;
  final String name;
  final String estimatedArrival;
  final double price;

  const ShippingTypeModel({
    required this.id,
    required this.name,
    required this.estimatedArrival,
    required this.price,
  });
}