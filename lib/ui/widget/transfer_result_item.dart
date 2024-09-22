import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../shared/theme.dart';

class TransferUserResultItem extends StatelessWidget {
  final UserModel user;
  final bool isSelected;
  const TransferUserResultItem({
    super.key,
    required this.user,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 185,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        border: Border.all(
          color: isSelected ? blueColor : whiteColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: user.profilePicture == null
                    ? const AssetImage(
                        'assets/img_profile.png',
                      )
                    : NetworkImage(user.profilePicture!) as ImageProvider,
              ),
            ),
            child: user.verified == 1
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: greenColor,
                          size: 16,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
                  user.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
          Center(
            child: Column(
              children: [
                
                const SizedBox(
                  height: 2,
                ),
                Text('${user.username}',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),overflow: TextOverflow.ellipsis,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
