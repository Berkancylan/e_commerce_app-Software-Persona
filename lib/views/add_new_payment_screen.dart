// lib/screens/add_payment_screen.dart
import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/payment_provider.dart';
import 'package:provider/provider.dart';
import '../components/credit_card_widget.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController holderController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final FocusNode cvvFocusNode = FocusNode();
  bool isCvvFocused = false;

  @override
  void initState() {
    super.initState();
    cvvFocusNode.addListener(() {
      setState(() {
        isCvvFocused = cvvFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    numberController.dispose();
    holderController.dispose();
    dateController.dispose();
    cvvController.dispose();
    cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add New Card", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: numberController.text,
                cardHolder: holderController.text,
                expiryDate: dateController.text,
                cvv: cvvController.text,
                isBackVisible: isCvvFocused,
              ),

              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(color: const Color(0xfff5f5f7), borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  onChanged: (val) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: "Card Number",
                    counterText: "",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.credit_card, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(color: const Color(0xfff5f5f7), borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  controller: holderController,
                  onChanged: (val) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: "Cardholder",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xfff5f5f7), borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: dateController,
                        maxLength: 5,
                        onChanged: (val) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: "Year/Month",
                          counterText: "",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xfff5f5f7), borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: cvvController,
                        focusNode: cvvFocusNode,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        onChanged: (val) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: "CVV",
                          counterText: "",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (numberController.text.isNotEmpty && holderController.text.isNotEmpty && dateController.text.isNotEmpty && cvvController.text.isNotEmpty) {
                      context.read<PaymentProvider>().addPaymentMethod(
                            holderController.text,
                            numberController.text,
                            dateController.text,
                            cvvController.text,
                          );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please complete all fields.")));
                    }
                  },
                  child: const Text("Save Card", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}