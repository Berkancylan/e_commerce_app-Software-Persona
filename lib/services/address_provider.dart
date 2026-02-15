import 'package:flutter/material.dart';
import '../models/address_model.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> addresses = [
    AddressModel(
      title: "Ev",
      address: "Barbaros Mah. Çiğdem Sok. No:5/12 Çankaya/Ankara",
      isSelected: true, 
    ),
    AddressModel(
      title: "Ofis",
      address: "ODTÜ Teknokent Gümüş Blok No:22, Ankara",
      isSelected: false,
    ),
  ];


  AddressModel? get selectedAddress {
    try {
      return addresses.firstWhere((element) => element.isSelected);
    } catch (e) {
      return null;
    }
  }

  void addAddress(String title, String fullAddress) {
    addresses.add(
      AddressModel(
        title: title,
        address: fullAddress,
      ),
    );
    notifyListeners();
  }

  void deleteAddress(int index) {
    addresses.removeAt(index);
    notifyListeners();
  }

  void selectAddress(int index) {
    for (int i = 0; i < addresses.length; i++) {
      addresses[i].isSelected = (i == index);
    }
    notifyListeners();
  }
}