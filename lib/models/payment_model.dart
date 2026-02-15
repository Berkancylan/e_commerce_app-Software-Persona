class PaymentModel {
  final String cardHolderName;
  final String cardNumber; // Sadece son 4 haneyi göstermek için
  final String expiryDate;
  final String cvv;
  bool isSelected;

  PaymentModel({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.isSelected = false,
  });
}