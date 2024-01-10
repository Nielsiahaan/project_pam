import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/component/future_method/combined_date_picker.dart';
import 'package:frontendapp/views/component/future_method/submit_formIB.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinBermalamForm extends StatefulWidget {
  const IzinBermalamForm({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[400],
        title: Text(
          'Request Izin Bermalam',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CombinedDateTimePicker(
                  title: 'Rencana Berangkat',
                  selectedDateTime: _rencanaBerangkat,
                  updateDateTime: _updateRencanaBerangkat,
                ),
                const SizedBox(height: 16.0),
                CombinedDateTimePicker(
                  title: 'Rencana Kembali',
                  selectedDateTime: _rencanaKembali,
                  updateDateTime: _updateRencanaKembali,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _keperluanController,
                  maxLines: 6,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Keperluan Izin Bermalam',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal[400],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.teal[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tujuanController,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tujuan Izin Bermalam',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal[400],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.teal[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => submitFormIB(
                    _rencanaBerangkat,
                    _rencanaKembali,
                    _keperluanController,
                    _tujuanController,
                    _requestIBController,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Buat Baru',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
