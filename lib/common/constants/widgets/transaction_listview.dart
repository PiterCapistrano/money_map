import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/models/transaction_model.dart';
import 'package:money_map/features/home/home_controller.dart';
import 'package:money_map/features/home/widgets/balance_card/balance_card_widget_controller.dart';
import 'package:money_map/locator.dart';

class TransactionListview extends StatelessWidget {
  const TransactionListview({
    super.key,
    required this.transactionList,
    this.itemCount,
  });

  final List<TransactionModel> transactionList;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount ?? transactionList.length,
      itemBuilder: (context, index) {
        final item = transactionList[index];

        final color =
            item.value.isNegative ? AppColors.lightRed : AppColors.green;
        final value = "\$ ${item.value.toStringAsFixed(2)}";
        return ListTile(
          onTap: () async {
            final result = await Navigator.pushNamed(
              context,
              '/transaction',
              arguments: item,
            );
            if (result != null) {
              locator.get<HomeController>().getAllTransactions();
              locator.get<BalanceCardWidgetController>().getBalances();
            }
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            DateTime.fromMillisecondsSinceEpoch(item.date).toString(),
            style: AppTextStyles.smallText13,
          ),
          trailing: Text(
            value,
            style: AppTextStyles.mediumText18.apply(color: color),
          ),
        );
      },
    );
  }
}
