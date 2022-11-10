class PlayerStatus {
  final String? R_Humerus,
      L_Humerus,
      R_Arm,
      L_Arm,
      R_Thigh,
      L_Thigh,
      R_Leg,
      L_Leg,
      Shoulders,
      Waist,
      Chest,
      Neck,
      Hips,
      Weight,
      Height;
  final DateTime CheckDate;

  const PlayerStatus({
    required this.R_Humerus,
    required this.L_Humerus,
    required this.R_Arm,
    required this.L_Arm,
    required this.R_Thigh,
    required this.L_Thigh,
    required this.R_Leg,
    required this.L_Leg,
    required this.Shoulders,
    required this.Waist,
    required this.Chest,
    required this.Hips,
    required this.Neck,
    required this.Weight,
    required this.Height,
    required this.CheckDate,
  });

  factory PlayerStatus.fromJson(Map<String, dynamic> json) {
    print(json);
    return PlayerStatus(
      R_Humerus: json['R_Humerus'],
      L_Humerus: json['L_Humerus'],
      R_Arm: json['R_Arm'],
      L_Arm: json['L_Arm'],
      R_Thigh: json['R_Thigh'],
      L_Thigh: json['L_Thigh'],
      R_Leg: json['R_Leg'],
      L_Leg: json['L_Leg'],
      Shoulders: json['Shoulders'],
      Waist: json['Waist'],
      Chest: json['Chest'],
      Neck: json['Neck'] ?? '0',
      Weight: json['Weight'],
      Height: json['Height'],
      Hips: json['Hips'],
      CheckDate: DateTime.parse(json['Check_Date']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'R_Humerus': R_Humerus,
      'L_Humerus': L_Humerus,
      'R_Arm': R_Arm,
      'L_Arm': L_Arm,
      'R_Thigh': R_Thigh,
      'L_Thigh': L_Thigh,
      'R_Leg': R_Leg,
      'L_Leg': L_Leg,
      'Shoulders': Shoulders,
      'Waist': Waist,
      'Chest': Chest,
      'Hips': Hips,
      'Neck': Neck,
      'Weight': Weight,
      'Height': Height,
      'Check_Date': CheckDate.toIso8601String(),
    };
  }
}
