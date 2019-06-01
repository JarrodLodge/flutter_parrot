class NlpResponse {
  final List<NlpResponseItem> response;

  NlpResponse(this.response);
  NlpResponse.fromJson(Map<String, dynamic> json) : response = json['answers'];
}

class NlpResponseItem {
  final String keyword;
  final String salience;
  final String language;

  NlpResponseItem(this.keyword, this.salience, this.language);
  NlpResponseItem.fromJson(Map<String, dynamic> json) : keyword = json['keyword'], salience = json['salience'], language = json['language'];
}