class CardModel {
  final String id;
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  const CardModel({
    required this.id,
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  String get maskedNumber {
    final clean = cardNumber.replaceAll(' ', '');
    if (clean.length < 16) return cardNumber;
    return '${clean.substring(0, 4)} ${clean.substring(4, 8)} ${clean.substring(8, 12)} ${clean.substring(12, 16)}';
  }

  String get lastFour => cardNumber.replaceAll(' ', '').substring(12);
}