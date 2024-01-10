import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/views/component/future_method/combined_date_picker.dart';
import 'package:frontendapp/views/component/future_method/submit_formIK.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinKeluarForm extends StatefulWidget {
  const IzinKeluarForm({super.key});

  @override
  _IzinKeluarFormState createState() => _IzinKeluarFormState();
}

class _IzinKeluarFormState extends State<IzinKeluarForm> {
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());
  DateTime _rencanaBerangkat = DateTime.now();
  DateTime _rencanaKembali = DateTime.now();
  final TextEditingController _keperluanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Request Izin Keluar',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[400],
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
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
                      maxLines: 3,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Keperluan IK',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal[
                              400],
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
                      )),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => submitFormIK(
                      _rencanaBerangkat,
                      _rencanaKembali,
                      _keperluanController,
                      _requestIKController,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
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
        ],
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
