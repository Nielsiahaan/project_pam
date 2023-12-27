import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/component/future_method/select_date.dart';
import 'package:frontendapp/views/component/future_method/select_time.dart';
import 'package:frontendapp/views/component/future_method/submit_formIB.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class IzinBermalamForm extends StatefulWidget {
  @override
  _IzinBermalamFormState createState() => _IzinBermalamFormState();
}

class _IzinBermalamFormState extends State<IzinBermalamForm> {
  final RequestIBController _requestIBController =
      Get.put(RequestIBController());
  DateTime _rencanaBerangkat = DateTime.now();
  DateTime _rencanaKembali = DateTime.now();
  TextEditingController _keperluanController = TextEditingController();
  TextEditingController _tujuanController = TextEditingController();

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
          'Request Izin Bermalam',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDateTimeInput(
                  label: 'Rencana Berangkat',
                  value: formatDate(_rencanaBerangkat),
                  onTap: () => selectDate(
                    context,
                    _rencanaBerangkat,
                    _updateRencanaBerangkat,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildDateTimeInput(
                  label: 'Waktu Berangkat',
                  value:
                      "${TimeOfDay.fromDateTime(_rencanaBerangkat).format(context)}",
                  onTap: () => selectTime(
                    context,
                    true,
                    _rencanaBerangkat,
                    _updateRencanaBerangkat,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildDateTimeInput(
                  label: 'Rencana Kembali',
                  value: formatDate(_rencanaKembali),
                  onTap: () => selectDate(
                    context,
                    _rencanaKembali,
                    _updateRencanaKembali,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildDateTimeInput(
                  label: 'Waktu Kembali',
                  value:
                      "${TimeOfDay.fromDateTime(_rencanaKembali).format(context)}",
                  onTap: () => selectTime(
                    context,
                    false,
                    _rencanaKembali,
                    _updateRencanaKembali,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildTextInput(
                  controller: _keperluanController,
                  label: 'Keperluan Izin Bermalam',
                  maxLines: 6,
                ),
                SizedBox(height: 16.0),
                _buildTextInput(
                  controller: _tujuanController,
                  label: 'Tujuan Izin Bermalam',
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => submitFormIB(
                    _rencanaBerangkat,
                    _rencanaKembali,
                    _keperluanController,
                    _tujuanController,
                    _requestIBController,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child:
                      Text('Buat Baru', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeInput(
      {required String label,
      required String value,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Pilih Tanggal',
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(
      {required TextEditingController controller,
      required String label,
      int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
