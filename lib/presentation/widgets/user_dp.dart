import 'package:flutter/material.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/presentation/widgets/app_fade_in_image.dart';

class UserDp extends StatelessWidget {
  const UserDp({
    Key? key,
    required this.size,
    this.useFaker = true,
    this.imageUrl,
    this.active = false,
    this.activeAWhileAgo = false,
  })  : assert(useFaker != false && imageUrl == null),
        super(key: key);
  final double size;
  final String? imageUrl;
  final bool useFaker;
  final bool active;
  final bool activeAWhileAgo;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = const BoxDecoration(
        color: AppColors.backgroundColor, shape: BoxShape.circle);
    var indicatorSize = size * 0.308;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                      child: AppFadeInImage(url: imageUrl ?? getFakeImage())),
                  if (activeAWhileAgo)
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        height: sizeFraction(30),
                        color: AppColors.greenLight,
                        padding: EdgeInsets.symmetric(
                            vertical: sizeFraction(4),
                            horizontal: sizeFraction(12)),
                        alignment: Alignment.center,
                        child: FittedBox(
                            child: Text(
                          "10 min",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    )
                ],
              ),
            ),
          ),
          if (active && !activeAWhileAgo)
            Container(
              height: indicatorSize,
              width: indicatorSize,
              padding: const EdgeInsets.all(3),
              decoration: boxDecoration,
              child: Container(
                decoration: boxDecoration.copyWith(color: AppColors.green),
              ),
            )
        ],
      ),
    );
  }

  double sizeFraction(double percentage) => (size / 100) * percentage;

  String getFakeImage() {
    return faker.image.image(
        keywords: ["person"], width: getFakerSize(), height: getFakerSize());
  }

  int getFakerSize() => (size + ((size / 100) * 10)).toInt();
}
