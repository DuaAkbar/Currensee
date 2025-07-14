import 'package:curren_see/controllers/userPreference_controller.dart';
import 'package:curren_see/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Userpreference extends StatefulWidget {
  @override
  State<Userpreference> createState() => _UserpreferenceState();
}

class _UserpreferenceState extends State<Userpreference> {
  final UserpreferenceController controller = Get.put(
    UserpreferenceController(),
  );

  NavigationServices navigationServices = Get.find<NavigationServices>();
  final TextEditingController amountcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Preference",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 35,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/settings');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedCurrency.value,
                      items:
                          controller.currencies
                              .map(
                                (c) =>
                                    DropdownMenuItem(child: Text(c), value: c),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.updateCurrency(value);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        controller.amount.value = double.tryParse(value) ?? 1.0;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                if (controller.exchangeRates.isEmpty) {
                  return Center(child: Text("No rates loaded."));
                }
                return ListView.builder(
                  itemCount: controller.currencies.length,
                  itemBuilder: (context, index) {
                    final target = controller.currencies[index];
                    if (target == controller.selectedCurrency.value)
                      return SizedBox.shrink();
                    final converted = controller
                        .convertTo(target)
                        .toStringAsFixed(2);
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            target[0],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          target,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          '$converted',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
