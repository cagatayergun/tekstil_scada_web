import 'package:flutter/material.dart';
import 'recipe_list_page.dart'; // Bir sonraki adımda oluşturacağız.

class RecipeSettingsPage extends StatelessWidget {
  const RecipeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reçete Ayarları')),
      body: ListView(
        children: [
          _buildRecipeTypeTile(
            context,
            'Boyama',
            Icons.water_drop,
            Colors.blue,
          ),
          const Divider(),
          _buildRecipeTypeTile(context, 'Yıkama', Icons.wash, Colors.lightBlue),
          const Divider(),
          _buildRecipeTypeTile(context, 'Sıkma', Icons.compress, Colors.grey),
          const Divider(),
          _buildRecipeTypeTile(
            context,
            'Kurutma',
            Icons.thermostat,
            Colors.orange,
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildRecipeTypeTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeListPage(machineType: title),
          ),
        );
      },
    );
  }
}
