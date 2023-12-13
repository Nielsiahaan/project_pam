import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class IzinKeluarForm extends StatefulWidget {
  @override
  _IzinKeluarFormState createState() => _IzinKeluarFormState();
}

class _IzinKeluarFormState extends State<IzinKeluarForm> {
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());
  DateTime _rencanaBerangkat = DateTime.now();
  DateTime _rencanaKembali = DateTime.now();
  TextEditingController _keperluanController = TextEditingController();

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  Future<void> _selectTime(
      BuildContext context, bool isRencanaBerangkat) async {
    TimeOfDay currentTime = isRencanaBerangkat
        ? TimeOfDay.fromDateTime(_rencanaBerangkat)
        : TimeOfDay.fromDateTime(_rencanaKembali);

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isRencanaBerangkat) {
          _rencanaBerangkat = DateTime(
            _rencanaBerangkat.year,
            _rencanaBerangkat.month,
            _rencanaBerangkat.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        } else {
          _rencanaKembali = DateTime(
            _rencanaKembali.year,
            _rencanaKembali.month,
            _rencanaKembali.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }
      });
    }
  }

  Future<void> _selectDate(
      BuildContext context, bool isRencanaBerangkat) async {
    DateTime currentDate =
        isRencanaBerangkat ? _rencanaBerangkat : _rencanaKembali;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        if (isRencanaBerangkat) {
          _rencanaBerangkat = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            _rencanaBerangkat.hour,
            _rencanaBerangkat.minute,
          );
        } else {
          _rencanaKembali = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            _rencanaKembali.hour,
            _rencanaKembali.minute,
          );
        }
      });
    }
  }

  Future<void> _submitForm() async {
    DateTime currentDate = DateTime.now();

    // Validate if the selected dates are not before the current date
    if (_rencanaBerangkat.isBefore(currentDate) ||
        _rencanaKembali.isBefore(currentDate)) {
      Get.snackbar(
        'Error',
        'Tidak dapat memilih tanggal atau waktu sebelum hari ini.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
      return;
    }

    // Validate if tanggal_kembali is after tanggal_berangkat
    if (_rencanaKembali.isBefore(_rencanaBerangkat)) {
      Get.snackbar(
        'Error',
        'Tanggal kembali harus setelah tanggal berangkat.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
      return;
    }

    try {
      await _requestIKController.createRequestIK(
        deskripsi: _keperluanController.text,
        tanggal_berangkat: _rencanaBerangkat,
        tanggal_kembali: _rencanaKembali,
      );

      _keperluanController.clear();
      setState(() {
        _rencanaBerangkat = currentDate;
        _rencanaKembali = currentDate;
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal melakukan request Izin Keluar Kampus.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Izin Keluar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Rencana Berangkat',
                    hintText: 'Pilih Tanggal',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(_rencanaBerangkat),
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectTime(context, true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Waktu Berangkat',
                    hintText: 'Pilih Jam dan Menit',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${TimeOfDay.fromDateTime(_rencanaBerangkat).format(context)}",
                      ),
                      Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Rencana Kembali',
                    hintText: 'Pilih Tanggal',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(_rencanaKembali),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectTime(context, false),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Waktu Kembali',
                    hintText: 'Pilih Jam dan Menit',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${TimeOfDay.fromDateTime(_rencanaKembali).format(context)}",
                      ),
                      Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _keperluanController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Keperluan IK',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Buat Baru'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
