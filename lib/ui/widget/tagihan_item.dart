// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';

import 'package:air_pam/models/tagihan_model.dart';
import 'package:intl/intl.dart';

class TagihanItem extends StatelessWidget {
  final TagihanModel tagihanCard;
  final bool isSelected;

  const TagihanItem({
    Key? key,
    required this.tagihanCard,
    required this.isSelected,
  }) : super(key: key);

  String formatDate(String tanggal) {
  try {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(tanggal);

    // Define the date format with commas
    DateFormat formatter = DateFormat('EEEE, d MMMM yyyy'); // Day name, day, month, year

    // Format the DateTime object into the desired string format
    return formatter.format(dateTime);
  } catch (e) {
    print('Error parsing date: $e');
    return tanggal; // Return the original string if parsing fails
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(
          width: 2,
          color: isSelected ? blueColor : Colors.transparent,
        ),
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan air PAM',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      formatDate(tagihanCard.tanggal.toString()),
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: light,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meteran Sebelum',
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          tagihanCard.meteranTerakhir.toString(),
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meteran Sekarang',
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          tagihanCard.meteran.toString(),
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Menyelaraskan semua widget di awal (atas)
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jumlah Bayar',
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                        SizedBox(height: 0), // Jarak vertikal antara dua teks
                        Text(
                          formatCurrency(tagihanCard.jumlahTagihan ?? 0),
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width:
                            16), // Jarak horizontal antara teks dan Container
                    Container(
                    decoration: BoxDecoration(
                      color: tagihanCard.status == 'Y' ? Colors.greenAccent.shade400 : Colors.redAccent.shade400, // Warna latar belakang berubah sesuai status
                      borderRadius: BorderRadius.circular(20), // Membuat sudut melengkung
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Sesuaikan ukuran baris dengan konten
                      children: [
                        Icon(
                          tagihanCard.status == 'Y' ? Icons.check_circle : Icons.access_time_filled_sharp, // Ikon berubah sesuai status
                          color: Colors.white, // Warna ikon
                          size: 20, // Ukuran ikon
                        ),
                        SizedBox(width: 6), // Jarak antara ikon dan teks
                        Text(
                          tagihanCard.status == 'Y' ? 'Sudah Bayar' : 'Belum Bayar', // Teks berubah sesuai status
                          style: whiteTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
