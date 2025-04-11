import 'package:flutter/material.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:excuse_generator/services/excuse_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/category_chip.dart';

class CreateExcusePage extends StatefulWidget {
  const CreateExcusePage({super.key});

  @override
  State<CreateExcusePage> createState() => _CreateExcusePageState();
}

class _CreateExcusePageState extends State<CreateExcusePage> {
  final _formKey = GlobalKey<FormState>();
  final _excuseController = TextEditingController();
  String _selectedCategory = 'General';
  String _creatorName = '';

  @override
  void dispose() {
    _excuseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final excuseService = Provider.of<ExcuseService>(context);
    final categories = excuseService.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Excuse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newExcuse = Excuse(
                  id: const Uuid().v4(),
                  text: _excuseController.text,
                  category: _selectedCategory,
                  isCustom: true,
                  creatorName: _creatorName.isNotEmpty ? _creatorName : null,
                );
                excuseService.addCustomExcuse(newExcuse);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _excuseController,
                decoration: const InputDecoration(
                  labelText: 'Your excuse',
                  hintText: 'Enter your creative excuse here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an excuse';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: categories.map((category) {
                  return CategoryChip(
                    category: category,
                    isSelected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your name (optional)',
                  hintText: 'Who created this excuse?',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _creatorName = value,
              ),
              const SizedBox(height: 20),
              const Text(
                'Pro Tip: Make your excuse believable and specific for better results!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}