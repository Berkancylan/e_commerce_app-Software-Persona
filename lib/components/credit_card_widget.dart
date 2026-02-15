import 'package:flutter/material.dart';
import 'dart:math'; 

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final bool isBackVisible;

  const CreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
    required this.isBackVisible,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: isBackVisible ? 1 : 0),
      duration: const Duration(milliseconds: 600),
      builder: (context, double value, child) {
        final angle = value * pi;
        final isFront = angle < pi / 2;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          alignment: Alignment.center,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF2C2C2C), Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: isFront
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.nfc, color: Colors.white54),
                            Icon(Icons.credit_card, color: Colors.white, size: 32),
                          ],
                        ),
                        Text(
                          cardNumber.isEmpty ? "**** **** **** ****" : formatCardNumber(cardNumber),
                          style: const TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2, fontFamily: 'Courier'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("KART SAHİBİ", style: TextStyle(color: Colors.white54, fontSize: 10)),
                                Text(
                                  cardHolder.isEmpty ? "AD SOYAD" : cardHolder.toUpperCase(),
                                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("SKT", style: TextStyle(color: Colors.white54, fontSize: 10)),
                                Text(
                                  expiryDate.isEmpty ? "AA/YY" : expiryDate,
                                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi), 
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Container(height: 40, color: Colors.black), 
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Container(height: 40, color: Colors.grey[800])),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    cvv.isEmpty ? "***" : cvv,
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Align(alignment: Alignment.bottomRight, child: Icon(Icons.credit_card, color: Colors.white54)),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  String formatCardNumber(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (i % 4 == 0 && i != 0) buffer.write(' ');
      buffer.write(input[i]);
    }
    return buffer.toString();
  }
}