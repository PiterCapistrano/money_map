import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/custom_circular_progress.dart';
import 'package:money_map/common/extensions/sizes.dart';
import 'package:money_map/features/home/home_controller.dart';
import 'package:money_map/features/home/home_state.dart';
import 'package:money_map/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  final controller = locator.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'God afternoon,',
                      // ignore: deprecated_member_use
                      textScaleFactor: textScaleFactor,
                      style:
                          AppTextStyles.smallText.apply(color: AppColors.white),
                    ),
                    Text(
                      'Enjelin Morgeana',
                      // ignore: deprecated_member_use
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyles.mediumText20
                          .apply(color: AppColors.white),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    // ignore: deprecated_member_use
                    color: AppColors.white.withOpacity(0.06),
                  ),
                  child: Stack(
                    alignment: const AlignmentDirectional(0.5, -0.5),
                    children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        color: AppColors.white,
                      ),
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: AppColors.notification,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24.w,
            right: 24.w,
            top: 155.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 32.h,
              ),
              decoration: const BoxDecoration(
                color: AppColors.trueDarkGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            // ignore: deprecated_member_use
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyles.mediumText16
                                .apply(color: AppColors.white),
                          ),
                          Text(
                            '\$ 1,556.00',
                            // ignore: deprecated_member_use
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyles.mediumText30
                                .apply(color: AppColors.white),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => log('options'),
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            Icons.more_horiz,
                            color: AppColors.white,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              height: 24.0,
                              child: Text("Item 1"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: AppColors.white.withOpacity(0.06),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_downward,
                              color: AppColors.white,
                              size: iconSize,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Income',
                                // ignore: deprecated_member_use
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyles.mediumText16
                                    .apply(color: AppColors.white),
                              ),
                              Text(
                                '\$ 1,840.00',
                                // ignore: deprecated_member_use
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyles.mediumText20
                                    .apply(color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: AppColors.white.withOpacity(0.06),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_upward,
                              color: AppColors.white,
                              size: iconSize,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expenses',
                                // ignore: deprecated_member_use
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyles.mediumText16
                                    .apply(color: AppColors.white),
                              ),
                              Text(
                                '\$ 284.00',
                                // ignore: deprecated_member_use
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyles.mediumText20
                                    .apply(color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction History',
                        style: AppTextStyles.mediumText18,
                      ),
                      Text(
                        'See all',
                        style: AppTextStyles.inputLabelText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        if (controller.state is HomeStateLoading) {
                          return const CustomCircularProgress(
                            color: AppColors.darkGreen,
                          );
                        }

                        if (controller.state is HomeStateError) {
                          return const Center(
                            child: Text('An error has occured'),
                          );
                        }

                        if (controller.transactions.isEmpty) {
                          return const Center(
                            child:
                                Text('There is no transactions at this time.'),
                          );
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final item = controller.transactions[index];

                            final color = item.value.isNegative
                                ? AppColors.lightRed
                                : AppColors.green;
                            final value = "\$ ${item.value.toStringAsFixed(2)}";
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                ),
                              ),
                              title: Text(
                                item.description,
                                style: AppTextStyles.mediumText16,
                              ),
                              subtitle: Text(
                                DateTime.fromMillisecondsSinceEpoch(item.date)
                                    .toString(),
                                style: AppTextStyles.smallText13,
                              ),
                              trailing: Text(
                                value,
                                style: AppTextStyles.mediumText18
                                    .apply(color: color),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
