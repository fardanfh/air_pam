import 'package:air_pam/blocs/operator_card/operator_card_bloc.dart';
import 'package:air_pam/models/operator_card_model.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';


class DataProviderItem extends StatelessWidget {
  final OperatorCardModel operatorCard;
  final bool isSelected;
  const DataProviderItem({
    super.key,
    required this.operatorCard,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        22,
      ),
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          operatorCard.thumbnail == null
              ? const Icon(Icons.abc)
              : Image.network(
                  operatorCard.thumbnail.toString(),
                  height: 30,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                operatorCard.name.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                operatorCard.status.toString(),
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
