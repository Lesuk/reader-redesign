# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users_list = [
  [ "Lesuk", "lesuk93@yahoo.com", "lesuk", "19931993", true ],
  [ "Дмитрo Воронов", "rhmgerm66an@ukr.net", "voronov", "19931993", false ],
  [ "Олег Угрин", "rmgerma@ukr.net", "oleg", "19931993", false ],
  [ "Romgerman", "romgerman@ukr.net", "romgerman", "19931993", false ],
  [ "Roman Subrichack", "romg7ermn@ukr.net", "Subrichack", "19931993", false ],
  [ "Maryana Pukas", "romg67rman@ukr.net", "Maryana", "19931993", false ],
  [ "Alex Mekhovov", "romgera@ukr.net", "Mekhovov", "19931993", false ],
  [ "Andrii Furmanets", "rmgerma@ukr.net", "Furmanets", "19931993", false ],
  [ "Олег Угрин", "rmgerma@ukr.net", "oleg", "19931993", false ],
]
users_list.each do |user|
  User.create(name: user[0], email: user[1], login: user[2], password: user[3], password_confirmation: user[3], admin: user[4])
end