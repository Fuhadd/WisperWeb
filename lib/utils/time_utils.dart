class TimeUtils {
  static calculateTimeDiffernce(DateTime postTime) {
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(postTime);

    int seconds = difference.inSeconds;
    int minutes = difference.inMinutes;
    int hours = difference.inHours;
    int days = difference.inDays;
    int months = (currentTime.year - postTime.year) * 12 +
        currentTime.month -
        postTime.month;
    int years = currentTime.year - postTime.year;
    if (seconds < 60) {
      return '$seconds seconds ago';
    } else if (minutes < 60) {
      return '$minutes minutes ago';
    } else if (hours < 24) {
      return '$hours hours ago';
    } else if (days < 30) {
      return '$days days ago';
    } else if (months < 12) {
      return '$months months ago';
    } else {
      return '$years years ago';
    }
  }
}
