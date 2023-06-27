// ignore_for_file: unrelated_type_equality_checks
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/controllers/presence_controller.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';

class CustomAlertDialog {
  static confirmation({
    required String title,
    required String message,
    required String label,
    required String hint,
    required bool obsecureText,
    required RxBool isLoading,
    required BuildContext context,
    String? onConfirmText,
    required void Function() onConfirm,
    required void Function() onCancel,
    required TextEditingController controller,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                      color: BlackSoftColor,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14)),
                ),
              ],
            ),
          ),
          CustomInput(
            context: context,
            margin: const EdgeInsets.only(bottom: 24),
            controller: controller,
            label: label,
            hint: hint,
            obsecureText: obsecureText,
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Obx(
                () => (!isLoading.value)
                    ? Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: ElevatedButton(
                              onPressed: onCancel,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: Colors.black12,
                                elevation: 0,
                              ),
                              child: const Text(
                                "batal",
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 6,
                            child: ElevatedButton(
                              onPressed: onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: successColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                              ),
                              child: Text(onConfirmText ?? 'konfirmasi'),
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: (!isLoading.value) ? onConfirm : () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: successColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text(
                          (!isLoading.value)
                              ? onConfirmText ?? 'konfirmasi'
                              : "loading...",
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static presenceRemote({
    required String title,
    required String message,
    required RxBool isLoading,
    required BuildContext context,
    String? onConfirmText,
    required Stream<DocumentSnapshot<Map<String, dynamic>>>? streamRemote,
    required void Function() onImagePick,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    const imageUrl = "https://ui-avatars.com/api/?name=Arlan Hendra";
    String? photoURL;
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          // content camera
          Column(children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: streamRemote,
                builder: (context, snapshot) {
                  if (snapshot.data?.data() != null) {
                    Map<String, dynamic> tempRemote = snapshot.data!.data()!;

                    photoURL = tempRemote["photoURL"];
                    return GestureDetector(
                      onTap: onImagePick, // pick image
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: CachedNetworkImage(
                                imageUrl: (tempRemote["photoURL"] != null)
                                    ? tempRemote["photoURL"]
                                    : imageUrl,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.grey,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: onImagePick, // pick image
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.grey,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ]),
          // button
          TextButton(
            onPressed: () {},
            child: Text(
              "Hapus gambar",
              style: TextStyle(
                color: softBlueColor,
                fontSize: Constant.textSize(context: context, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.black12,
                      elevation: 0,
                    ),
                    child: const Text(
                      "batal",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(onConfirmText ?? 'konfirmasi'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static attendanceDialog({
    required String title,
    required String message,
    required BuildContext context,
    required void Function() onCancel,
  }) {
    final presenceC = Get.find<PresenceController>();
    String? status;
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          // title, message
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10),
          // dropdown
          DropdownSearch<String>(
            clearButtonProps: const ClearButtonProps(
                icon: Icon(
                  Ionicons.close,
                  size: 20,
                ),
                isVisible: true),
            popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                searchFieldProps: TextFieldProps(
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
                listViewProps: const ListViewProps(
                  padding: EdgeInsets.only(bottom: 6),
                )
                // disabledItemFn: (String s) => s.startsWith('I'),5
                ),
            items: const ["Kantor", "Dinas Luar"],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                label: Text(
                  "Status Kehadiran",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const UnderlineInputBorder(),
                hintText: "Pilih status kehadiran",
                hintStyle: TextStyle(
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
            onChanged: (value) {
              status = value;
            },
          ),
          const SizedBox(height: 20),
          // button
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.black12,
                      elevation: 0,
                    ),
                    child: Text(
                      "batal",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (status != null) {
                        switch (status) {
                          case "Kantor":
                            presenceC.presence();
                            break;
                          case "Dinas Luar":
                            //* check if already presence today
                            if (await presenceC.isTodayPresence() == false) {
                              Get.back();
                              Get.toNamed(Routes.PRESENCE_REMOTE);
                            } else {
                              Get.back();
                              CustomToast.infoToast(
                                  "Anda telah absen hari ini",
                                  "Silahkan melakukan absen kehadiran pada lain hari",
                                  Get.context!);
                            }
                            break;
                          default:
                        }
                      } else {
                        CustomToast.infoToast(
                            "Anda belum memilih status kehadiran",
                            "Silahkan memilih status kehadiran untuk melanjutkan",
                            Get.context!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(
                      "konfirmasi",
                      style: TextStyle(
                        fontSize:
                            Constant.textSize(context: context, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static showDialog({
    required String title,
    required String message,
    required RxBool isLoading,
    required BuildContext context,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: Obx(
              () => (!isLoading.value)
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.black12,
                              elevation: 0,
                            ),
                            child: Text(
                              "batal",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: successColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: Text(
                              "konfirmasi",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: (!isLoading.value) ? onConfirm : () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: successColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        (!isLoading.value) ? "konfirmasi" : "loading...",
                        style: TextStyle(
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  static showDialogWithTime({
    required String title,
    required String message,
    required RxBool isLoading,
    required RxBool canPressed,
    required RxInt countTapped,
    required BuildContext context,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Obx(
              () => (!isLoading.value)
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.black12,
                              elevation: 0,
                            ),
                            child: const Text(
                              "batal",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: canPressed != false ? onConfirm : () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: successColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: Text((canPressed.value != false)
                                ? "konfirmasi"
                                : "waiting..."),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: (!isLoading.value) ? onConfirm : () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: successColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        (!isLoading.value) ? "konfirmasi" : "loading...",
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  static showDialog2({
    required String title,
    required String message,
    required BuildContext context,
    String? onConfirmText,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.black12,
                      elevation: 0,
                    ),
                    child: const Text(
                      "batal",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(onConfirmText ?? 'konfirmasi'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static showDialogWithoutConfirm({
    required String title,
    required String message,
    required BuildContext context,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.black12,
                elevation: 0,
              ),
              child: const Text(
                "tutup",
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showPhoto({
    String? photoURL,
    required BuildContext context,
  }) {
    const imageUrl = "https://ui-avatars.com/api/?name=Arlan";
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: CachedNetworkImage(
              imageUrl: photoURL ?? imageUrl,
              placeholder: (context, url) =>
                  CircularProgressIndicator(color: primaryColor),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.black12,
                elevation: 0,
              ),
              child: const Text(
                "tutup",
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static approvalDialog({
    required String type,
    required String detail,
    String? photoURL,
    required RxBool isLoading,
    required BuildContext context,
    required void Function() onApprove,
    required void Function() onReject,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Persetujuan",
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Silahkan pilih salah satu opsi berikut untuk melakukan persetujian ataupun penolakan",
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Keterangan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.textSize(context: context, fontSize: 12),
                ),
              ),
              Text(
                detail,
                style: TextStyle(
                  color: BlackSoftColor,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
            ],
          ),
          (photoURL != null) ? const SizedBox(height: 26) : const SizedBox(),
          (photoURL != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Foto",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 12),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          backgroundColor: secondaryColor),
                      onPressed: () => CustomAlertDialog.showPhoto(
                          context: context, photoURL: photoURL),
                      child: Text(
                        "Lihat Foto",
                        style: TextStyle(
                          fontSize:
                              Constant.textSize(context: context, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 26),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Obx(
              () => (isLoading.value != true)
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onApprove,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: successColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: const Text("setujui"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onReject,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dangerColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: const Text("tolak"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.black12,
                              elevation: 0,
                            ),
                            child: const Text(
                              "batal",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: successColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        "loading...",
                        style: TextStyle(
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  static addCutiTahunan({
    required RxBool isLoading,
    required BuildContext context,
    required DateTime selectedDate,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tambah Cuti Tahunan",
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Silahkan mengisi kolom inputan untuk menambah cuti tahunan.",
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    YearPicker(
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 3, 13, 0),
                        selectedDate: selectedDate,
                        onChanged: (date) {
                          selectedDate = date;
                        });
                  },
                  child: Text("select year"),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: Obx(
              () => (!isLoading.value)
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.black12,
                              elevation: 0,
                            ),
                            child: Text(
                              "batal",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: successColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: Text(
                              "tambah",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: (!isLoading.value) ? onConfirm : () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: successColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        (!isLoading.value) ? "tambah" : "loading...",
                        style: TextStyle(
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  static showDialog3({
    required String title,
    required String message,
    required BuildContext context,
    required Widget content,
    String? onConfirmText,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          //*========== WIDGET ==========*//
          content,
          //*========== END WIDGET ==========*//
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.black12,
                      elevation: 0,
                    ),
                    child: const Text(
                      "batal",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(onConfirmText ?? 'konfirmasi'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
