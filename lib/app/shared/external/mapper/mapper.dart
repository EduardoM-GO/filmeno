abstract interface class Mapper<T extends Object> {
  T fromMap(Map<String, dynamic> map);
}
