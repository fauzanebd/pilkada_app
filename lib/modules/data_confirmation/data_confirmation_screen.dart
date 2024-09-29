import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';

class DataConfirmationScreen extends GetView<DataConfirmationController> {
  const DataConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('building data confirmation screen');
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Data')),
      body: Stack(
        children: [
          Obx(() => ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildTextField('Name', controller.dataPemilih.value!.name,
                      (value) => controller.dataPemilih.value!.name = value),
                  _buildTextField('NIK', controller.dataPemilih.value!.nik,
                      (value) => controller.dataPemilih.value!.nik = value),
                  _buildTextField(
                      'Address',
                      controller.dataPemilih.value!.address,
                      (value) => controller.dataPemilih.value!.address = value),
                  _buildDatePicker(
                      'Birth Date',
                      controller.dataPemilih.value!.birthDate,
                      (value) =>
                          controller.dataPemilih.value!.birthDate = value),
                  _buildDropdown(
                      'Gender',
                      controller.dataPemilih.value!.gender,
                      ['L', 'PEREMPUAN'],
                      (value) => controller.dataPemilih.value!.gender = value),
                  _buildTextField(
                      'Phone Number',
                      controller.dataPemilih.value!.noPhone,
                      (value) => controller.dataPemilih.value!.noPhone = value),
                  _buildTextField(
                      'TPS Number',
                      controller.dataPemilih.value!.noTps,
                      (value) => controller.dataPemilih.value!.noTps = value),
                  _buildBooleanDropdown(
                      'Is Party Member',
                      controller.dataPemilih.value!.isPartyMember,
                      (value) =>
                          controller.dataPemilih.value!.isPartyMember = value),
                  _buildTextField(
                      'Category',
                      controller.dataPemilih.value!.category,
                      (value) =>
                          controller.dataPemilih.value!.category = value),
                  _buildTextField(
                      'Expectation to Candidate',
                      controller.dataPemilih.value!.expectationToCandidate,
                      (value) => controller
                          .dataPemilih.value!.expectationToCandidate = value),
                  _buildTextField(
                      'Positioning to Candidate',
                      controller.dataPemilih.value!.positioningToCandidate,
                      (value) => controller
                          .dataPemilih.value!.positioningToCandidate = value),
                  _buildTextField(
                      'Relation to Candidate',
                      controller.dataPemilih.value!.relationToCandidate,
                      (value) => controller
                          .dataPemilih.value!.relationToCandidate = value),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.saveData,
                    child: const Text('Save Data'),
                  ),
                ],
              )),
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, String? value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDatePicker(
      String label, String? value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: Get.context!,
            initialDate: value != null ? DateTime.parse(value) : DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            onChanged(DateFormat('yyyy-MM-dd').format(picked));
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(labelText: label),
          child: Text(value ?? 'Select Date'),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }

  Widget _buildBooleanDropdown(
      String label, bool? value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<bool>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: const [
          DropdownMenuItem<bool>(value: true, child: Text('Yes')),
          DropdownMenuItem<bool>(value: false, child: Text('No')),
        ],
        onChanged: (bool? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}
