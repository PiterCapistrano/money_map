import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/notification_widget.dart';
import 'package:money_map/common/extensions/sizes.dart';
import 'package:money_map/features/home/widgets/greetings_widget.dart';

class AppHeader extends StatefulWidget {
  final String? title;
  final bool hasOptions;

  const AppHeader({
    super.key,
    this.title,
    this.hasOptions = false,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  Widget get _innerHeader => widget.title != null
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 32.0,
                color: AppColors.white,
              ),
            ),
            Text(widget.title!,
                style:
                    AppTextStyles.mediumText18.apply(color: AppColors.white)),
            widget.hasOptions
                ? const Icon(
                    Icons.more_horiz,
                    size: 32.0,
                    color: AppColors.white,
                  )
                : const SizedBox(width: 16.0),
          ],
        )
      : const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GreetingsWidget(),
            NotificationWidget(),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.greenGradient,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(500, 30),
                bottomRight: Radius.elliptical(500, 30),
              ),
            ),
            height: 287.h,
          ),
        ),
        Positioned(
          left: 24.0,
          right: 24.0,
          top: 74.h,
          child: _innerHeader,
        ),
      ],
    );
  }
}
