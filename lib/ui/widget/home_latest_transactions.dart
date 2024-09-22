import 'package:air_pam/models/transaction_model.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLatestTransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  const HomeLatestTransactionItem({
    super.key,
    required this.transaction,
  });

  String thumbnail() {
    if (transaction.transactionType?.code == 'transfer') {
      return 'https://api.silabkon.my.id/storage/rnIFGQXNOz.png';
    } else if (transaction.transactionType?.code == 'top_up') {
      return 'https://bwabank.my.id/storage/xmamMx8utB.png';
    } else {
      return 'https://bwabank.my.id/storage/tL3YMHgck4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: const EdgeInsets.only(
    bottom: 0,
  ),
  decoration: BoxDecoration(
    color: Colors.white, // Card background color
    borderRadius: BorderRadius.circular(15), // Rounded corners
    
  ),
  padding: const EdgeInsets.all(16), // Padding inside the card
  child: Row(
    children: [
      // Thumbnail Image
      ClipRRect(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the image
        child: Image.network(
          thumbnail(),
          width: 48,
          height: 48,
          fit: BoxFit.cover, // Ensures the image covers the box
        ),
      ),
      const SizedBox(
        width: 16,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type
            Text(
              transaction.transactionType!.name.toString(),
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold, // Bold text for emphasis
                color: Colors.black87, // Slightly muted black for elegance
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            // Transaction Date
            Text(
              DateFormat('MMM dd, yyyy').format(
                transaction.createdAt ?? DateTime.now(),
              ),
              style: greyTextStyle.copyWith(
                fontSize: 12,
                color: Colors.grey[600], // Softer grey for date text
              ),
            ),
          ],
        ),
      ),
      // Transaction Amount
      Text(
        formatCurrency(
          transaction.amount ?? 0,
          symbol: transaction.transactionType?.action == 'cr' ? '+ ' : '- ',
        ),
        style: blackTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: transaction.transactionType?.action == 'cr'
              ? Colors.green // Green for credits
              : Colors.redAccent, // Red for debits
        ),
      ),
    ],
  ),
);
  }
}
