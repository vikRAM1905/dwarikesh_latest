import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/add_expense_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/model/expanse_list_model.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/input_field.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpense extends StatelessWidget {
  final AddExpenseController _controller = Get.put(AddExpenseController());

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: primaryColorDark,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    );

    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: "addFinanceEntry".tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(15.r),
            height: 48.h,
            child: ButtonField(
              text: "add_expense".tr,
              color: primaryColor,
              press: () {
                _controller.getExpenseResponseApiData();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
          elevation: 0,
        ),
        body: GetBuilder<AddExpenseController>(
          builder: (controller) => SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('total_area'.tr,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 15,
                ),
                if (controller.responseCode == '200')
                  areaTile(context, 'cane_area'.tr, controller.caneArea.value),
                SizedBox(
                  height: 8,
                ),
                areaTile(context, 'culturable_area'.tr,
                    controller.culturableArea.value),
                SizedBox(
                  height: kToolbarHeight / 2,
                ),
                Text('enter_your_area'.tr,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 8,
                ),
                if (controller.responseCode == '200')
                  Text(controller.userAreaTitle.value,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 5,
                ),
                if (controller.responseCode == '200')
                  InputField(
                    keyboardType: TextInputType.number,
                    moveCurser: TextInputAction.done,
                    controller: controller.areaTextController,
                    maxLines: 1,
                    onChanged: (value) {
                      controller.areaValidation(value);
                    },
                  ),
                SizedBox(
                  height: 30,
                ),
                Text('select_particulars'.tr,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                if (controller.responseCode == '200')
                  if (controller.resListData.length > 0)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.resListData.length,
                        itemBuilder: (context, index) {
                          var data = controller.resListData[index];
                          // print("Response : ${data.category}");
                          // print("Response Index : ${index}");
                          // return resultTile(context, data, index);
                          return subProductTile(context, data, index);
                        })
                  else
                    ErrorMessage(
                      errorCode: '403',
                    )
                else if (controller.responseCode == '404')
                  ErrorMessage(
                    errorCode: '404',
                  )
                else if (controller.responseCode == '500')
                  ErrorMessage(
                    errorCode: '500',
                  )
                else
                  ErrorMessage(
                    errorCode: '403',
                  )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget areaTile(BuildContext context, String title, String data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
        Text(data,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget subProductTile(BuildContext context, Data data, int sectionIndex) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kToolbarHeight / 10,
            ),
            Text(data.category!,
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            GetBuilder<AddExpenseController>(
                builder: (controller) => ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: kToolbarHeight / 2.5),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.particulars!.length,
                    itemBuilder: (context, index) {
                      //controller.editTextControllers.add(new TextEditingController());
                      // print("editTextControllers List : ${controller.editTextControllers.length}");
                      var subDatas = data.particulars![index];
                      var currentIndex = "$sectionIndex$index";
                      if (data.type == 'checkbox'.tr) {
                        //print("checkbox ${controller.editTextControllers[index]}");
                        return checkboxproductTile(
                            context,
                            subDatas,
                            controller.editTextControllers[index],
                            int.parse(currentIndex),
                            index,
                            sectionIndex);
                      } else {
                        return radioproductTile(
                            context,
                            subDatas,
                            controller.editTextControllers[index],
                            int.parse(currentIndex),
                            index,
                            sectionIndex);
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Widget checkboxproductTile(
      BuildContext context,
      Particulars model,
      TextEditingController controllertxt,
      int section,
      int index,
      int sectionIndex) {
    return GetBuilder<AddExpenseController>(
        builder: (controller) => GestureDetector(
              onTap: () {
                if (!model.getCheckboxButton) {
                  model.checkbox = true;
                  print("CheckBox Index $section");
                  controller.saveCheckboxParticularsData(
                      model, controller.editTextControllers[section].text);
                  controller.update();
                } else {
                  model.checkbox = false;
                  controller.removeCheckboxParticularsData(model);
                  controller.update();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                model.checkbox!
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank,
                                color:
                                    model.checkbox! ? Colors.red : textColor),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.productTitle!,
                                      style: TextStyle(
                                          color: model.checkbox!
                                              ? Colors.red
                                              : Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  if (model.checkbox!)
                                    editBoxValue(
                                        context: context,
                                        title: model.subTitle!,
                                        controllertxt: controller
                                            .editTextControllers[section],
                                        model: model,
                                        section: section,
                                        sectionIndex: sectionIndex,
                                        index: index)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget radioproductTile(
      BuildContext context,
      Particulars model,
      TextEditingController controllertxt,
      int section,
      int index,
      int sectionIndex) {
    _controller.radioButtonArray.add(model);
    //print("radioButtonArray : ${_controller.radioButtonArray.length}");
    return GetBuilder<AddExpenseController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.radioButtonArray
              .forEach((element) => element.radioButton = false);

          if (!model.getRadioButton) {
            model.setRadioButton = true;
            print("Selected Radio Index ${model.getRadioButton}");
            controller.saveRadioParticularsData(
                model, controller.editTextControllers[section].text);
            controller.update();
          } else {
            model.setRadioButton = false;
            print("Remove Radio Index ${model.getRadioButton}");
            controller.removeCheckboxParticularsData(model);
            controller.update();
          }

          controller.radioButtonArray.refresh();
          //  controller.saveCheckboxParticularsData(model,controller.editTextControllers[section].text);
          // // controller.saveParticularsData(model,controllertxt.text);
          //  controller.update();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                          model.getRadioButton
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: model.getRadioButton ? Colors.red : textColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.productTitle!,
                                style: TextStyle(
                                    color: model.radioButton!
                                        ? Colors.red
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            if (model.radioButton!)
                              editBoxValue(
                                  context: context,
                                  title: model.subTitle!,
                                  controllertxt:
                                      controller.editTextControllers[section],
                                  model: model,
                                  section: section,
                                  sectionIndex: sectionIndex,
                                  index: index)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editBoxValue(
      {BuildContext? context,
      String? title,
      TextEditingController? controllertxt,
      Particulars? model,
      int? section,
      int? index,
      int? sectionIndex}) {
    return GetBuilder<AddExpenseController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(title!,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  keyboardType: TextInputType.number,
                  moveCurser: TextInputAction.done,
                  controller: controllertxt!,
                  maxLines: 1,
                  onChanged: (value) {
                    // for(int i = 0; i<controller.quantitiesList.length; i++){
                    //   if(model.id == controller.quantitiesList[i].id){
                    //     controller.quantitiesList[i].setQty = value;
                    //     print("{id: ${controller.quantitiesList[i].id},type: ${controller.quantitiesList[i].type},qty: ${controller.quantitiesList[i].getQty}}");
                    //   }
                    // }
                    // controller.saveCheckboxParticularsData(model,controller.editTextControllers[section].text);
                    // controller.update();
                    //print('DAATA Edit box INSIDE ${controllertxt.text}');
                    //controller.saveParticularsData(model,value);
                    controller.expenseValidation(
                        index!, section!, sectionIndex!, model!);
                    // if(model.id == controller.quantitiesList[section].id){
                    //   controller.quantitiesList[section].setQty = value;
                    //   print("{id: ${controller.quantitiesList[section].id},type: ${controller.quantitiesList[section].type},qty: ${controller.quantitiesList[section].getQty}}");
                    // }
                    // print(controller.editTextControllers.length);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ));
  }
}
