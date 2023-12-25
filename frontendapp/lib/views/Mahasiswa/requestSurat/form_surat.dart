import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class SuratFormPage extends StatefulWidget {
  @override
  _SuratFormPageState createState() => _SuratFormPageState();
}

class _SuratFormPageState extends State<SuratFormPage> {
  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());
  DateTime _selectedDate = DateTime.now();
  TextEditingController _kategoriSuratController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    // Check if the user selected a date
    if (pickedDate != null && pickedDate != _selectedDate) {
      // Check if the picked date is after or equal to the current date
      if (pickedDate.isAfter(currentDate) ||
          pickedDate.isAtSameMomentAs(currentDate)) {
        setState(() {
          _selectedDate = pickedDate;
        });
      } else {
        // Show an error message if the selected date is before the current date
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat memilih tanggal sebelumnya.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Surat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Form Pengajuan Surat',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _kategoriSuratController,
                decoration: InputDecoration(labelText: 'Kategori Surat'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Isi Surat',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Pengambilan',
                    hintText: 'Pilih Tanggal',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${formatDate(_selectedDate)}",
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _requestSuratController.storeSuratRequest(
                    kategori_surat: _kategoriSuratController.text,
                    content: _contentController.text,
                    tanggal_pengambilan: _selectedDate,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Ajukan Surat',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
