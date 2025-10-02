
import 'package:biboo_pro/domain/models/Child/child.dart';

class ChildrenDataManager {
  static final ChildrenDataManager _instance = ChildrenDataManager._internal();
  factory ChildrenDataManager() => _instance;
  ChildrenDataManager._internal();

  final List<Child> _children = [
    Child(
      id: 'ID 123456789',
      name: 'Samah Mili',
      birth: 'Mars 25, 2025',
      parent: 'Souhaila Lamri',
      gov: 'Sousse',
      className: 'PS',
      avatar: 'assets/images/avatar_1.png',
      parentPhone: '+216 12345678',
      parentEmail: 'souhaila@email.com',
      paymentMethod: 'Cache',
      gender: 'Femelle',
      subscriptionFee: '300',
      subscriptionDiscount: '0',
      registrationFee: '50',
      registrationDiscount: '0',
      transportFee: '100',
      transportDiscount: '0',
    ),
    Child(
      id: 'ID 987654321',
      name: 'Wajdi Lkhchini',
      birth: 'Mars 25, 2025',
      parent: 'Othmen Lkhchini',
      gov: 'Sfax',
      className: 'TPS',
      avatar: 'assets/images/avatar_1.png',
      parentPhone: '+216 87654321',
      parentEmail: 'othmen@email.com',
      paymentMethod: 'Chéque',
      gender: 'Male',
      subscriptionFee: '350',
      subscriptionDiscount: '10',
      registrationFee: '50',
      registrationDiscount: '0',
      transportFee: '120',
      transportDiscount: '0',
    ),
  ];

  // Getter pour obtenir une copie non modifiable de la liste
  List<Child> get children => List.unmodifiable(_children);

  // Ajouter un enfant
  void addChild(Child child) {
    _children.add(child);
  }

  // Supprimer un enfant
  void removeChild(String id) {
    _children.removeWhere((child) => child.id == id);
  }

  // Modifier un enfant
  void updateChild(String id, Child updatedChild) {
    final index = _children.indexWhere((child) => child.id == id);
    if (index != -1) {
      _children[index] = updatedChild;
    }
  }

  // Générer un ID unique
  String generateId() {
    return 'ID ${DateTime.now().millisecondsSinceEpoch}';
  }
}