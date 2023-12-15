import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/views/Future_method/select_date.dart';
import 'package:frontendapp/views/Future_method/select_time.dart';
import 'package:frontendapp/views/Future_method/submit_formIK.dart';
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

  void _updateRencanaBerangkat(DateTime dateTime) {
    setState(() {
      _rencanaBerangkat = dateTime;
    });
  }

  void _updateRencanaKembali(DateTime dateTime) {
    setState(() {
      _rencanaKembali = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Izin Keluar',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => selectDate(
                    context, _rencanaBerangkat, _updateRencanaBerangkat),
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
                onTap: () => selectTime(
                    context, true, _rencanaBerangkat, _updateRencanaBerangkat),
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
                onTap: () =>
                    selectDate(context, _rencanaKembali, _updateRencanaKembali),
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
                onTap: () => selectTime(
                    context, false, _rencanaKembali, _updateRencanaKembali),
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
                onPressed: () => submitFormIK(
                  _rencanaBerangkat,
                  _rencanaKembali,
                  _keperluanController,
                  _requestIKController,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue, // Set the background color to blue
                ),
                child: Text('Buat Baru', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
