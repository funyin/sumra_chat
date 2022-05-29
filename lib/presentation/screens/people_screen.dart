import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/routes/app_routers.dart';
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
          child: BlocBuilder<ChatsCubit, ChatsState>(
            builder: (context, state) {
              var users = state.respondents;
              users.sort((a, b) => a.name.compareTo(b.name));
              return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder: (context, index) =>
                      listItem(users[index], context),
                  separatorBuilder: (context, index) => const Divider(
                        indent: 48,
                      ),
                  itemCount: users.length);
            },
          ),
        ),
      ],
    );
  }

  Widget listItem(user, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.chat);
      },
      child: Row(
        children: [
          UserDp(
            size: 40,
            user: user,
          ),
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
            decoration: const BoxDecoration(
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
    );
  }
}
