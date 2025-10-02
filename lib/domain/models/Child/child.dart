class Child {
  final String id;
  final String name;
  final String birth;
  final String parent;
  final String gov;
  final String className;
  final String avatar;
  final String parentPhone;
  final String parentEmail;
  final String paymentMethod;
  final String gender;
  final String subscriptionFee;
  final String subscriptionDiscount;
  final String registrationFee;
  final String registrationDiscount;
  final String transportFee;
  final String transportDiscount;

  Child({
    required this.id,
    required this.name,
    required this.birth,
    required this.parent,
    required this.gov,
    required this.className,
    required this.avatar,
    required this.parentPhone,
    required this.parentEmail,
    required this.paymentMethod,
    required this.gender,
    required this.subscriptionFee,
    required this.subscriptionDiscount,
    required this.registrationFee,
    required this.registrationDiscount,
    required this.transportFee,
    required this.transportDiscount,
  });
  static Child fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      birth: map['birth'] ?? '',
      parent: map['parent'] ?? '',
      gov: map['gov'] ?? '',
      className: map['class'] ?? '',
      avatar: map['avatar'] ?? 'assets/images/avatar_1.png',
      parentPhone: '',
      parentEmail: '',
      paymentMethod: 'Cache',
      gender: 'Male',
      subscriptionFee: '0',
      subscriptionDiscount: '0',
      registrationFee: '0',
      registrationDiscount: '0',
      transportFee: '0',
      transportDiscount: '0',
    );
  }
}