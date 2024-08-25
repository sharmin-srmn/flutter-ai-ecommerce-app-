import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../models/payment_method_model.dart';
import '../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        name: "Cash On Delivery", image: TImages.cashOnDelivery);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              //SPACE BETWEEN PAYMENT METHOD AND HEADING
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //CASH ON DELIVER (COD)
              TPaymentTile(
                paymentMethod: PaymentMethodModel(
                    image: TImages.cashOnDelivery, name: 'COD'),
              ),
              //SPACE BETWEEN PAYMENT OPTIONS
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              //BKASH
              TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: TImages.bkash, name: 'Bkash'),
              ),
              //SPACE BETWEEN PAYMENT OPTIONS
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              //NAGAD
              TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: TImages.nagad, name: 'Nagad'),
              ),
              //SPACE BETWEEN PAYMENT OPTIONS
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              //PAYPAL
              TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: TImages.paypal, name: 'PayPal'),
              ),
              //SPACE BETWEEN PAYMENT OPTIONS
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
