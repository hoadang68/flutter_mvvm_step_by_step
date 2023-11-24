class ApiResponse<T>{
  String? message;
  T? data;
  Status status;
  // ApiResponse(this.message, this.data, this.status)
  ApiResponse.initial(this.message): status = Status.initial;
  ApiResponse.loading(this.message): status = Status.loading;
  ApiResponse.complete(this.data): status = Status.complete;
  ApiResponse.error(this.message): status = Status.error;
}
enum Status{initial, loading,complete, error}