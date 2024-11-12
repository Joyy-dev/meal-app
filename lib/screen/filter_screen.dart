import 'package:flutter/material.dart';
import 'package:mealapp/widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FilterScreen(this.currentFilters, this.saveFilters, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(String title, String description, bool currentValue, void Function(bool) updateValue) {
    return SwitchListTile(
     title: Text(title),
     subtitle: Text(description),
    value: currentValue, 
    onChanged: updateValue,
   );
  }

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan']as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [IconButton(
          onPressed: () {
            final selectedFilters = {
             'gluten': false,
             'lactose': false,
             'vegan': false,
             'vegetarian': false,
            };
            widget.saveFilters(selectedFilters);
          }, 
          icon: const Icon(Icons.save)
          )],
      ),

      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const Text('Adjust your meal selection.',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'OpenSans'
          ),
          ),
          ),
          Expanded(
            child: ListView(
              children: [
               _buildSwitchListTile(
                'Gluten-free', 
                'Only include gluten-free meals', 
                _glutenFree, 
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                } 
               ),
               _buildSwitchListTile(
                'Vegetarian', 
                'Only Include Vegetarian meals', 
                _vegetarian, 
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                  'Vegan', 
                  'Only include Vegan meals', 
                  _vegan, 
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                    'Lasctose-Free', 
                    'Only include Lactode-free meals', 
                    _lactoseFree, 
                    (newValue) {
                      _lactoseFree = newValue;
                    })
              ],
            ))
      ],)
    );
  }
}