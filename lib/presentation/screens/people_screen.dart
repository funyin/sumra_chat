import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Recently active".toUpperCase(),
            style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(0.34),
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (context, index) => Row(
                    children: [
                      UserDp(
                          size: 40,
                          active: true,
                          activeAWhileAgo: index == 0 ? false : true),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            faker.person.name(),
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.grey1, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          Assets.vectorsIcWave,
                          color: AppColors.iconColorActive,
                          width: 16,
                          height: 16,
                        ),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => Divider(
                    indent: 48,
                  ),
              itemCount: 10),
        ),
      ],
    );
  }
}
