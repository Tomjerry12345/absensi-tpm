import 'package:absensi/screen/absensi/absensi_controller.dart';
import 'package:absensi/utils/space_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class AbsensiScreen extends StatelessWidget {
  const AbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AbsensiController controller = Get.put(AbsensiController());
    String tanggalWaktu =
        DateFormat("dd MMM yyyy, HH:mm").format(DateTime.now());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pengguna: ${controller.email}"),
                  V(8),
                  Text("Tanggal & Waktu: $tanggalWaktu"),
                  V(8),
                  Text(
                      "Lokasi: ${controller.alamat.value ?? 'Mendeteksi lokasi...'}"),
                  V(8),
                  Text(
                    "Status: ${controller.sudahAbsen.value ? "Sudah Absen" : "Belum Absen"}",
                    style: TextStyle(
                      color: controller.sudahAbsen.value
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  V(20),

                  // Preview foto
                  controller.fotoSelfie.value != null
                      ? Image.file(controller.fotoSelfie.value!, height: 200)
                      : const Text("Belum ambil foto selfie"),

                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.ambilFoto,
                    child: const Text("Ambil Foto Selfie"),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (!controller.sudahAbsen.value &&
                            controller.dalamRadius.value &&
                            controller.fotoSelfie.value != null)
                        ? () => controller.absenSekarang(context)
                        : null,
                    child: const Text("Absen Sekarang"),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

// class AbsensiScreen extends StatefulWidget {
//   const AbsensiScreen({Key? key}) : super(key: key);

//   @override
//   State<AbsensiScreen> createState() => _AbsensiScreenState();
// }

// class _AbsensiScreenState extends State<AbsensiScreen> {
//   final AbsensiController controller = Get.put(AbsensiController());

//   @override
//   Widget build(BuildContext context) {
//     String tanggalWaktu =
//         DateFormat("dd MMM yyyy, HH:mm").format(DateTime.now());

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Obx(() => Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("Pengguna: ${controller.email}"),
//                   V(8),
//                   Text("Tanggal & Waktu: $tanggalWaktu"),
//                   V(8),
//                   Text(
//                       "Lokasi: ${controller.alamat.value ?? 'Mendeteksi lokasi...'}"),
//                   V(8),
//                   Text(
//                     "Status: ${controller.sudahAbsen.value ? "Sudah Absen" : "Belum Absen"}",
//                     style: TextStyle(
//                       color: controller.sudahAbsen.value
//                           ? Colors.green
//                           : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   V(20),

//                   // Preview foto
//                   controller.fotoSelfie.value != null
//                       ? Image.file(controller.fotoSelfie.value!, height: 200)
//                       : const Text("Belum ambil foto selfie"),

//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: controller.ambilFoto,
//                     child: const Text("Ambil Foto Selfie"),
//                   ),

//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: (!controller.sudahAbsen.value &&
//                             controller.dalamRadius.value &&
//                             controller.fotoSelfie.value != null)
//                         ? () => controller.absenSekarang(context)
//                         : null,
//                     child: const Text("Absen Sekarang"),
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
