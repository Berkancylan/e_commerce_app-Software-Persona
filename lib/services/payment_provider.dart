import 'package:flutter/material.dart';
import '../models/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  List<PaymentModel> paymentMethods = [
    PaymentModel(
      cardHolderName: "BERKAN CEYLAN",
      cardNumber: "4543 1234 5678 9010",
      expiryDate: "12/28",
      cvv: "123",
      isSelected: true,
    ),
    PaymentModel(
      cardHolderName: "BERKAN İŞ",
      cardNumber: "5522 1234 5678 1111",
      expiryDate: "10/26",
      cvv: "456",
      isSelected: false,
    ),
  ];

  PaymentModel? get selectedPaymentMethod {
    try {
      return paymentMethods.firstWhere((element) => element.isSelected);
    } catch (e) {
      return null;
    }
  }

  void addPaymentMethod(String holderName, String number, String date, String cvv) {
    paymentMethods.add(
      PaymentModel(
        cardHolderName: holderName,
        cardNumber: number,
        expiryDate: date,
        cvv: cvv,
      ),
    );
    notifyListeners();
  }

  void deletePaymentMethod(int index) {
    bool wasSelected = paymentMethods[index].isSelected;
    paymentMethods.removeAt(index);

    if (wasSelected && paymentMethods.isNotEmpty) {
      paymentMethods[0].isSelected = true;
    }

    notifyListeners();
  }

  void selectPaymentMethod(int index) {
    for (int i = 0; i < paymentMethods.length; i++) {
      paymentMethods[i].isSelected = (i == index);
    }
    notifyListeners();
  }
}