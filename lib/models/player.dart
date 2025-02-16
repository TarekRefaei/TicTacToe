class Player {
  final String playerName;
  final String socketID;
  final double points;
  final String playerType;

  Player({
    required this.playerName,
    required this.socketID,
    required this.points,
    required this.playerType,
  });


  Player copyWith({
    String? playerName,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Player(
      playerName: playerName ?? this.playerName,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> playerData) {
    return Player(
      playerName: playerData['playerName'] ?? "",
      socketID: playerData['socketID'] ?? "",
      points: playerData['points'].toDouble() ?? 0.0,
      playerType: playerData['playerType'] ?? "",
    );
  }
}
