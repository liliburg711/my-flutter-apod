class ApodData {
  final String title; // 圖片標題
  final String url; // 圖片資源連結
  final String mediaType; // 圖片類型
  final String desc; // 圖片描述
  final String date; // 日期
  String note = '';
  bool isFavorite = false;

  ApodData(this.title, this.url, this.mediaType, this.desc, this.date,
      this.note, this.isFavorite);

  ApodData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        mediaType = json['media_type'],
        url = json['media_type'] == 'image'
            ? json['hdurl']
            : json['thumbnail_url'], // 如果當天的天文資料是影片檔，則取用影片截圖資源
        desc = json['explanation'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'media_type': mediaType,
        'url': url,
        'explanation': desc,
        'date': date,
      };
}
