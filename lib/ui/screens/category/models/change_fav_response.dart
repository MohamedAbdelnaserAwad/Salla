class ChangeFavoritesResponse
{
  bool? status;
  String? message;

  ChangeFavoritesResponse.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}