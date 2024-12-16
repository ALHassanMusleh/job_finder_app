class Job {
  late String id;
  late String title;
  late double salary;
  late String location;
  late String type;
  late String status;
  late List<String>? requirements;
  late String? image;
  late bool isImageUploaded;

  static const String collectionName = 'jobs';

  Job({
    required this.id,
    required this.title,
    required this.salary,
    required this.location,
    required this.type,
    required this.status,
    required this.requirements,
    required this.image,
    required this.isImageUploaded,
  });

  Job.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    salary = json['salary'];
    location = json['location'];
    type = json['type'];
    status = json['status'];
    image = json['image'];
    isImageUploaded = json['isImageUploaded'];
    if (json['requirements'] != null) {
      requirements = [];
      json['requirements'].forEach((v) {
        requirements!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['salary'] = salary;
    map['location'] = location;
    map['type'] = type;
    map['status'] = status;
    map['image'] = image;
    map['isImageUploaded'] = isImageUploaded;
    map['requirements'] = requirements;
    // if (requirements != null) {
    //   map['requirements'] = requirements?.map((v) => v).toList();
    // }
    return map;
  }
}
