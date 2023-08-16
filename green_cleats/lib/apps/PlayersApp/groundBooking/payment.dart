import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/payment_success.dart';
import 'package:green_cleats/utils/colors.dart';

class Payment extends StatefulWidget {
  var player_id;

  var slotId;

  var team_id;

  var groundId;

  var bookingFor;

  var packageId;

  var trainerId;

  Payment({
    super.key,
    required this.bookingFor,
    required this.player_id,
    this.groundId,
    this.slotId,
    this.team_id,
    this.packageId,
    this.trainerId,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final addressController = TextEditingController();
  final cnicController = TextEditingController();
  final numberController = TextEditingController();

  int value = 0;
  final paymentLabels = [
    'Credit Card / Debit Card',
    'Cash on ground',
    'Easy Paisa / Jazz Cash'
  ];
  final paymentIcons = [Icons.credit_card, Icons.money_off, Icons.payment];
  bool showCardForm = true;
  bool showCashForm = false;
  bool showEasypaisaForm = false;

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose your payment method",
              style: TextStyle(color: Colors.grey[400], fontSize: 28.0),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          ListTile(
                            leading: Radio(
                                activeColor: AppColors.animationGreenColor,
                                value: index,
                                groupValue: value,
                                onChanged: (i) => setState(() {
                                      value = i!;
                                      showCardForm = true;
                                      showCashForm = false;
                                      showEasypaisaForm = false;
                                    })),
                            title: Text(
                              paymentLabels[index],
                              style: TextStyle(
                                  color: AppColors.animationBlueColor),
                            ),
                            trailing: Icon(
                              paymentIcons[index],
                              color: AppColors.animationGreenColor,
                            ),
                          ),
                          if (showCardForm)
                            Container(
                              padding: EdgeInsets.all(12),
                              // Display credit/debit card form
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: cardNumberController,
                                    decoration: InputDecoration(
                                        labelText: 'Card Number'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(16),
                                      CardNumberFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter card number';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: TextFormField(
                                            controller: expiryController,
                                            decoration: InputDecoration(
                                                hintText: 'MM/YY',
                                                labelText: 'Expiry Date'),
                                            keyboardType:
                                                TextInputType.datetime,
                                            inputFormatters: [
                                              CardExpiryInputFormatter(),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter expiry date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            controller: cvvController,
                                            decoration: InputDecoration(
                                                labelText: 'CVV'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  3),
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter CVV';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          ListTile(
                            leading: Radio(
                                activeColor: AppColors.animationGreenColor,
                                value: index,
                                groupValue: value,
                                onChanged: (i) => setState(() {
                                      value = i!;
                                      showCardForm = false;
                                      showCashForm = true;
                                      showEasypaisaForm = false;
                                    })),
                            title: Text(
                              paymentLabels[index],
                              style: TextStyle(
                                  color: AppColors.animationBlueColor),
                            ),
                            trailing: Icon(
                              paymentIcons[index],
                              color: AppColors.animationGreenColor,
                            ),
                          ),
                          if (showCashForm)
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: addressController,
                                    decoration: InputDecoration(
                                        labelText: 'Address',
                                        hintText: "Enter your Address"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the address';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: cnicController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        labelText: 'CNIC',
                                        hintText: "Enter your CNIC number"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the cnic number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          ListTile(
                            leading: Radio(
                                activeColor: AppColors.animationGreenColor,
                                value: index,
                                groupValue: value,
                                onChanged: (i) => setState(() {
                                      value = i!;
                                      showCardForm = false;
                                      showCashForm = false;
                                      showEasypaisaForm = true;
                                    })),
                            title: Text(
                              paymentLabels[index],
                              style: TextStyle(
                                  color: AppColors.animationBlueColor),
                            ),
                            trailing: Icon(
                              paymentIcons[index],
                              color: AppColors.animationGreenColor,
                            ),
                          ),
                          if (showEasypaisaForm)
                            Container(
                              padding: EdgeInsets.all(12),
                              // Display EasyPaisa / JazzCash form
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: numberController,
                                    decoration: InputDecoration(
                                        labelText: 'Mobile Number'),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    default:
                      return SizedBox.shrink();
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: paymentLabels.length),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () async {
                // Logic to validate payment details => Start
                String paymentDetails = "";
                var message;
                if (showCardForm) {
                  if (cardNumberController.text.length > 16 &&
                      cvvController.text.length > 0 &&
                      expiryController.text.length > 0) {
                    if (cardNumberController.text
                            .substring(cardNumberController.text.length - 3) ==
                        cvvController.text) {
                      paymentDetails =
                          "${cardNumberController.text}-${cvvController.text}-${expiryController.text}";
                    } else {
                      message = "Invalid CVV";
                    }
                  } else {
                    message = "Invalid Card Details";
                  }
                } else if (showEasypaisaForm) {
                  if (numberController.text.length == 11) {
                    paymentDetails = "${numberController.text}";
                  } else {
                    message = "Invalid Easypaisa or Jazzcash Number";
                  }
                } else {
                  if (addressController.text.length > 0) {
                    if (cnicController.text.length == 13) {
                      paymentDetails =
                          "${addressController.text}-${cnicController.text}";
                    } else {
                      message = "Invalid CNIC";
                    }
                  } else {
                    message = "Invalid Address";
                  }
                }
                // Logic to validate payment details => End

                if (paymentDetails != "") {
                  if (widget.bookingFor == "ground") {
                    var response = await bookSlot(
                        widget.slotId,
                        widget.groundId,
                        widget.team_id,
                        widget.player_id,
                        paymentLabels[value]);
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentSuccess(
                                  player_id: widget.player_id,
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("${json.decode(response.body)['message']}"),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  } else if (widget.bookingFor == "trainer") {
                    var response = await bookPackage(
                        widget.packageId,
                        widget.trainerId,
                        widget.player_id,
                        paymentLabels[value],
                        paymentDetails);
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentSuccess(
                                  player_id: widget.player_id,
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("${json.decode(response.body)['message']}"),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              height: 60.0,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: AppColors.animationGreenColor,
              child: Text(
                "PAY",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
