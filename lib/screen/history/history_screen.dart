import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Obx(() {
      if (controller.history.isEmpty) {
        return const Center(child: Text("Belum ada riwayat absen"));
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.loadHistory();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.history.length,
          itemBuilder: (context, index) {
            final item = controller.history[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(item.fotoPath),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.tanggal),
                subtitle: Text(
                  item.statusLokasi,
                  style: TextStyle(
                    color: item.statusLokasi == "Valid"
                        ? Colors.green[800]
                        : Colors.red,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
