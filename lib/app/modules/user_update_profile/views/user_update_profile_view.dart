import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_datepicker.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/user_update_profile_controller.dart';

class UserUpdateProfileView extends GetView<UserUpdateProfileController> {
  const UserUpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Data Diri',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: ScreenUtilInit(
          builder: (context, child) => IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Ionicons.arrow_back,
              color: Colors.black87,
              size: 22.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 1.2,
              child: ListView(
                shrinkWrap: true,
                children: [
                  //* Nama
                  CustomInput(
                    context: context,
                    controller: controller.nameC,
                    label: "Nama",
                    hint: "John Doe",
                  ),
                  const SizedBox(height: 10),
                  //* Tempat Lahir
                  CustomInput(
                    context: context,
                    controller: controller.birthPlaceC,
                    label: "Tempat Lahir",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  //* Tanggal Lahir
                  Row(
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                            controller: controller.birthDateC,
                            label: "Tanggal Lahir",
                            hint: "-",
                            context: context),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xfff8dcdf),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            controller.pickDate(
                              context,
                              DateTime.now(),
                              DateTime(1930),
                              DateTime(DateTime.now().year + 2),
                            );
                          },
                          icon: Icon(
                            Ionicons.calendar,
                            size: 22,
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  //* Jenis Kelamin
                  customDropdown(context, "gender", ['Laki-laki', 'Perempuan'],
                      controller.genderC, controller.obsGender),
                  const SizedBox(height: 10),
                  //* Goldar
                  customDropdown(context, "goldar", ['A', 'B', 'O', 'AB'],
                      controller.goldarC, controller.obsGoldar),
                  const SizedBox(height: 10),
                  //* Alamat
                  CustomInput(
                    context: context,
                    controller: controller.addressC,
                    label: "Alamat",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  //* Nomor Telp
                  CustomInput(
                    context: context,
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneNumberC,
                    label: "Nomor Telp / WA",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  //* RT/RW
                  Row(
                    children: [
                      CustomInput(
                        context: context,
                        width: (Get.width - 50) * 0.5,
                        controller: controller.rtC,
                        keyboardType: TextInputType.number,
                        label: "RT",
                        hint: "-",
                      ),
                      const SizedBox(width: 10),
                      CustomInput(
                        context: context,
                        width: (Get.width - 50) * 0.5,
                        controller: controller.rwC,
                        keyboardType: TextInputType.number,
                        label: "RW",
                        hint: "-",
                      ),
                    ],
                  ),
                  //* Kel/Desa
                  const SizedBox(height: 10),
                  CustomInput(
                    context: context,
                    controller: controller.kelurahanC,
                    label: "Kel/Desa",
                    hint: "-",
                  ),
                  //* Kecamatan
                  const SizedBox(height: 10),
                  CustomInput(
                    context: context,
                    controller: controller.kecamatanC,
                    label: "Kecamatan",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  //* Agama
                  CustomInput(
                    context: context,
                    controller: controller.agamaC,
                    label: "Agama",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    context: context,
                    controller: controller.status_kawinC,
                    label: "Status Perkawinan",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    context: context,
                    controller: controller.pekerjaanC,
                    label: "Pekerjaan",
                    hint: "-",
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    context: context,
                    controller: controller.kewarganegaraanC,
                    label: "Kewarganegaraan",
                    hint: "-",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.updateProfile();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    // padding: EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: (controller.isLoading.isFalse)
                      ? Text(
                          'Ubah Data Diri',
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        )
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customDropdown(context, String type, List<String> listData,
      TextEditingController controller, RxString obs) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => FractionallySizedBox(
            heightFactor: type != "gender" ? 0.64 : 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (type != "goldar") {
                          switch (index) {
                            case 0:
                              controller.text = "Laki-laki";
                              obs.value = "Laki-laki";
                              Navigator.pop(context);
                              break;
                            case 1:
                              controller.text = "Perempuan";
                              obs.value = "Perempuan";
                              Navigator.pop(context);
                              break;
                            default:
                              "Laki-laki";
                          }
                        } else {
                          switch (index) {
                            case 0:
                              controller.text = "A";
                              obs.value = "A";
                              Navigator.pop(context);
                              break;
                            case 1:
                              controller.text = "B";
                              obs.value = "B";
                              Navigator.pop(context);
                              break;
                            case 2:
                              controller.text = "O";
                              obs.value = "O";
                              Navigator.pop(context);
                              break;
                            case 3:
                              controller.text = "AB";
                              obs.value = "AB";
                              Navigator.pop(context);
                              break;
                            default:
                              "A";
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColor.secondaryExtraSoft,
                                    width: 1,
                                    style: BorderStyle.solid))),
                        child: Text(listData[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.secondaryExtraSoft,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type != "gender" ? "Golongan Darah" : "Jenis Kelamin",
              style: TextStyle(
                color: AppColor.secondarySoft,
                fontSize: Constant.textSize(context: context, fontSize: 10),
              ),
            ),
            Obx(() => Text(
                  obs.value,
                  style: TextStyle(
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14)),
                )),
          ],
        ),
      ),
    );
  }
}
