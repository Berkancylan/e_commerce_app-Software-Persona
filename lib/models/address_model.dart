// lib/models/address_model.dart
import 'package:flutter/material.dart';

class AddressModel {
  final String title;
  final String address;
  bool isSelected;
  final IconData icon;

  AddressModel({
    required this.title,
    required this.address,
    this.isSelected = false,
    this.icon = Icons.location_on_outlined,
  });
}