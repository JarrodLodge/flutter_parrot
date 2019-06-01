class NlpResponse {
  final List<NlpResponseItem> response;

  NlpResponse(this.response);

  static NlpResponse fromJson(Map<String, dynamic> json) {
    List<NlpResponseItem> items = List<NlpResponseItem>();

    List<dynamic> decoded = json['answers'];
    for (var i = 0; i < decoded.length; i++) {
      var item = NlpResponseItem.fromJson(decoded[i]);
      items.add(item);
    }
    return NlpResponse(items);
  }
}

class NlpResponseItem {
  final String keyword;
  final int salience;
  final String language;

  NlpResponseItem(this.keyword, this.salience, this.language);
  NlpResponseItem.fromJson(Map<String, dynamic> json) : keyword = json['keyword'], salience = json['salience'], language = json['language'];
}