import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/payment_provider.dart';
import '../components/credit_card_widget.dart';
import 'add_new_payment_screen.dart'; 

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentProv = context.watch<PaymentProvider>();
    final selectedPayment = paymentProv.selectedPaymentMethod;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment Methods", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (selectedPayment != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children: [
                    const Text("Selected Card", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    CreditCardWidget(
                      cardNumber: selectedPayment.cardNumber,
                      cardHolder: selectedPayment.cardHolderName,
                      expiryDate: selectedPayment.expiryDate,
                      cvv: selectedPayment.cvv,
                      isBackVisible: false,
                    ),
                  ],
                ),
              ),
              
              Divider(
                color: Colors.grey.shade200, 
                thickness: 1,
                height: 1, 
              ),
              const SizedBox(height: 20), 
            ],

            Expanded(
              child: paymentProv.paymentMethods.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card_off_outlined, size: 64, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          const Text("No registered card", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: paymentProv.paymentMethods.length,
                      itemBuilder: (context, index) {
                        final card = paymentProv.paymentMethods[index];
                        return GestureDetector(
                          onTap: () => paymentProv.selectPaymentMethod(index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: card.isSelected ? Colors.black : const Color(0xfff5f5f7),
                                width: card.isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(color: Color(0xfff5f5f7), shape: BoxShape.circle),
                                  child: const Icon(Icons.credit_card, color: Colors.black, size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card.cardNumber,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${card.cardHolderName} - ${card.expiryDate}",
                                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                                if (card.isSelected) 
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10), 
                                    child: Icon(Icons.check_circle, color: Colors.black, size: 20)
                                  ),
                                IconButton(
                                  onPressed: () => paymentProv.deletePaymentMethod(index),
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPaymentScreen(),
                      ),
                    );
                  },
                  child: const Text("Add New Card", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}