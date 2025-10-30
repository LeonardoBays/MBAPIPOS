import 'package:equatable/equatable.dart';

import '../../core/constants/enum/match_status.dart';
import '../../core/util/extensions/date_time_extension.dart';

class Match extends Equatable {
  final String id;
  final DateTime startAt;
  final DateTime endAt;
  final String homeTeamName;
  final String awayTeamName;
  final int homeScore;
  final int awayScore;
  final DateTime createdAt;
  final String createdBy;
  final DateTime? deletedAt;

  const Match({
    this.id = "",
    required this.startAt,
    required this.endAt,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeScore,
    required this.awayScore,
    required this.createdAt,
    required this.createdBy,
    this.deletedAt,
  });

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'],
      startAt: DateTime.parse(map['start_at']),
      endAt: DateTime.parse(map['end_at']),
      homeTeamName: map['home_team_name'],
      awayTeamName: map['away_team_name'],
      homeScore: map['home_score'],
      awayScore: map['away_score'],
      createdAt: DateTime.parse(map['created_at']),
      createdBy: map['created_by'],
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'])
          : null,
    );
  }

  MatchStatus get status {
    final dtNow = DateTime.now();

    if (dtNow.isAfter(startAt) && dtNow.isBefore(endAt)) {
      return MatchStatus.onGoing;
    }

    if (dtNow.isBefore(startAt)) {
      return MatchStatus.waiting;
    }

    return MatchStatus.finished;
  }

  String get statusLabel {
    return switch (status) {
      MatchStatus.onGoing => 'Partida em andamento',
      MatchStatus.finished => 'Partida finalizada',
      MatchStatus.waiting =>
        'Partida programada para: '
            '${startAt.formatter(DatePattern.diaMesHoraMinuto)}',
    };
  }

  @override
  String toString() {
    return 'Match{'
        'id: $id, '
        'startAt: $startAt, '
        'endAt: $endAt, '
        'homeTeamName: $homeTeamName, '
        'awayTeamName: $awayTeamName, '
        'homeScore: $homeScore, '
        'awayScore: $awayScore, '
        'createdAt: $createdAt, '
        'createdBy: $createdBy, '
        'deletedAt: $deletedAt'
        '}';
  }

  @override
  List<Object?> get props => [
    id,
    startAt,
    endAt,
    homeTeamName,
    awayTeamName,
    homeScore,
    awayScore,
    createdAt,
    createdBy,
    deletedAt,
  ];
}
