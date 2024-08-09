import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Name'),
            TextField(),
            SizedBox(height: 16),
            Text('Category'),
            Row(
              children: [
                FilterChip(
                  label: Text('Design'),
                  onSelected: (bool selected) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Development'),
                  onSelected: (bool selected) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Research'),
                  onSelected: (bool selected) {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Date & Time'),
            // Add Date and Time Picker here
            SizedBox(height: 16),
            Text('Description'),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add task creation logic
              },
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
