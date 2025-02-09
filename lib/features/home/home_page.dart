import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/app_header.dart';
import 'package:money_map/common/constants/widgets/custom_circular_progress.dart';
import 'package:money_map/common/extensions/sizes.dart';
import 'package:money_map/features/home/home_controller.dart';
import 'package:money_map/features/home/home_state.dart';
import 'package:money_map/common/constants/widgets/transaction_listview.dart';
import 'package:money_map/features/home/widgets/balance_card/balance_card_widget.dart';
import 'package:money_map/features/home/widgets/balance_card/balance_card_widget_controller.dart';
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
  final balanceController = locator.get<BalanceCardWidgetController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTransactions();
    balanceController.getBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCard(controller: balanceController),
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

                        if (controller.state is HomeStateSuccess) {
                          return TransactionListView(
                            transactionList: controller.transactions,
                            itemCount: 5,
                          );
                        }

                        return const Center(
                          child: Text('There is no transactions at this time.'),
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
