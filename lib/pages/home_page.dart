import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: content(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  SafeArea content() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/knight.png', height: 300),
            const SizedBox(height: 20),
            const Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap + to add your tasks',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 232, 244, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: const Icon(Icons.home), onPressed: (() => {})),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: (() => {}),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                backgroundColor: const Color(0xFFEFF6FF),
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Add Task',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Task title',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Description',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.access_time),
                              iconSize: 32,
                              color: Colors.black87,
                              onPressed: () {
                                showCalendar(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.category),
                              iconSize: 32,
                              color: Colors.black87,
                              onPressed: () {
                                showCategories(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.flag),
                              iconSize: 32,
                              color: Colors.black87,
                              onPressed: () {
                                // Handle flagging or priority
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.star_border),
                              iconSize: 32,
                              color: Colors.black87,
                              onPressed: () {
                                // Handle favorite/importance toggle
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              iconSize: 32,
                              color: Colors.blue,
                              onPressed: () {
                                // Submit task
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              );
            },

            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 28, 123, 196),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: (() => {}),
          ),
          IconButton(icon: const Icon(Icons.inventory), onPressed: (() => {})),
        ],
      ),
    );
  }

  Future<dynamic> showCategories(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // <- this is key
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: const Color(0xFFEFF6FF),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Choose Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildCategoryTile(
                        Icons.shopping_bag_outlined,
                        'Grocery',
                        Colors.greenAccent,
                      ),
                      _buildCategoryTile(
                        Icons.work_outline,
                        'Work',
                        Colors.orangeAccent,
                      ),
                      _buildCategoryTile(
                        Icons.fitness_center,
                        'Sport',
                        Colors.cyanAccent,
                      ),
                      _buildCategoryTile(
                        Icons.brush,
                        'Design',
                        Colors.tealAccent,
                      ),
                      _buildCategoryTile(
                        Icons.school_outlined,
                        'University',
                        Colors.indigoAccent,
                      ),
                      _buildCategoryTile(
                        Icons.campaign_outlined,
                        'Social',
                        Colors.pinkAccent,
                      ),
                      _buildCategoryTile(
                        Icons.music_note_outlined,
                        'Music',
                        Colors.purpleAccent,
                      ),
                      _buildCategoryTile(
                        Icons.health_and_safety_outlined,
                        'Health',
                        Colors.lightGreenAccent,
                      ),
                      _buildCategoryTile(
                        Icons.movie_outlined,
                        'Movie',
                        Colors.lightBlueAccent,
                      ),
                      _buildCategoryTile(
                        Icons.home_outlined,
                        'Home',
                        Colors.orange.shade200,
                      ),
                      _buildCategoryTile(
                        Icons.add,
                        'Create New',
                        Colors.green.shade200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text(
                      'Add Category',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> showCalendar(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set task date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  // Save selected date: args.value
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'Choose Time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showTimepicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set task date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  // Save selected date: args.value
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Choose Time'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _buildCategoryTile(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle category selection logic here
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar header() {
  return AppBar(
    automaticallyImplyLeading: false, // Do not show back arrow
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 64,
    title: Stack(
      alignment: Alignment.center,
      children: [
        // Centered Title
        const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Left & Right Widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.filter_list, color: Colors.black),
            Row(
              children: [
                const Text(
                  '112',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset('assets/images/xp_coin.png', height: 20, width: 20),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
