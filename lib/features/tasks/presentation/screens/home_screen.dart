import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/tasks/presentation/provider/tasks_counter_providers.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/tasks/presentation/screens/photo_screen.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_botton_navbar.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_dialog_newtodo.dart';
import 'package:todo_app/features/tasks/presentation/widgets/todo_widget.dart';

import '../widgets/avatar_stack.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(todosProvider.notifier).loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodosProvider);

    final completedCounter = ref.watch(completedCounterProvider);
    final pendingCounter = ref.watch(pendingCounterProvider);
    final remindersCounter = ref.watch(remindersCounterProvider);
    final currentFilter = ref.watch(selectedFilterTodoProvider);

    final tasksTitleGroup = switch (currentFilter) {
      TodoFilter.all => 'All tasks',
      TodoFilter.completed => 'Completed tasks',
      TodoFilter.pending => 'Pending tasks',
      TodoFilter.reminders => 'Reminders tasks',
    };

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PhotoScreen() ));
                    },
                    child: Container(
                      height: 40,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.menu, color: Colors.grey,),
                    ),
                  ),
                  Text(
                    'Homepage',
                    style: TextStyle(
                      fontSize: 20, color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 Container(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.grey,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                      colors: [Colors.blue.withOpacity(0.4), Colors.blue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's progress summary",
                      style: TextStyle(
                        fontSize: 18, color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${pendingCounter.toString()} Tasks",
                      style: const TextStyle(
                        fontSize: 12, color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: AvatarStack()),
                        const Spacer(),
                        Column(
                          children: [
                            const Text("Progress         40%",  style: TextStyle(
                              fontSize: 12, color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),                           
                          Stack(
                            children: [
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.6),
                                  ),
                            ),
                            Container(
                              width: 60, // Example value: 40% progress
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                            ),
                              ],
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
           // TODOS TITLE FILTER
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text(
                tasksTitleGroup,
                style: GoogleFonts.roboto(
                  color: const Color(0xff8C8C8C),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //  TODOS LISTVIEW
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = todos[index];
                    return TodoWidget(
                      id: todo.id,
                      description: todo.description,
                      completed: todo.completed,
                      onTapCheckBox: () {
                        ref.read(todosProvider.notifier).toggleTodo(todo.id);
                      },
                      onTapDelete: () {
                        ref.read(todosProvider.notifier).deleteTodo(todo.id);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // newTodoAlert(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CustomDialogNewTodo(
                onPressedCreate: () {
                  final newTodo = ref.read(newTodoProvider);
                  if (newTodo.isNotEmpty) {
                    ref
                        .read(todosProvider.notifier)
                        .addTodo(description: newTodo);
                    ref.read(newTodoProvider.notifier).update((state) => '');
                    ref
                        .read(selectedFilterTodoProvider.notifier)
                        .update((state) => TodoFilter.all);
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
