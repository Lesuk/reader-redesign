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

new_htc = Article.create! title: "Новий HTC One (The All New One, 2014) на відео ", user_id: 1, publish_date: 1.weeks.ago, content: <<-ARTICLE
В мережі інтернет з'явилося відео в якому демонструється робота нового ще не анонсованого смартфона HTC - One (The All New One, 2014). За останніми відомостями, пристрій буде представлений в Лондоні 25 березня. В цей же день стартують і його продажі.
Нагадаємо, HTC One (The All New One, 2014) отримав 5-дюймовий дисплей з роздільною здатністю 1920х1080 пікселів, 4-ядерний процесор Qualcomm Snapdragon 801 з тактовою частотою 1,7 ГГц, 2 Гб оперативної та 16/32 Гб вбудованої пам'яті (передбачено слот для карт MicroSD до 128 Гб), 4-мегапіксельну Ultrapixel основну камеру, стандартний набір радіо модулів і Android 4.4.2 KitKat в якості операційної системи. Габарити: 146х70,5х9,5 мм, вага - 157 г.
ARTICLE

sssd2 = Article.create! title: "Samsung представила нову лінійку планшетів - Galaxy Tab 4", user_id: 1, publish_date: 1.weeks.ago, content: <<-ARTICLE
Компанія Samsung офіційно представила нову лінійку планшетів - Galaxy Tab 4. В її склад ввійшли 10,1-, 8- і 7-дюймові девайси з роздільною здатністю дисплеїв 1280х800 пікселів. В продажі, планшети з'являться у поточному кварталі. Ціна - не відома.
Samsung Galaxy Tab 4 10,1, 8 і 7 отримав 4-ядерний процесор Snapdragon Snapdragon 400 з тактовою частотою 1,2 ГГц, 1,5 Гб оперативної та 16 Гб вбудованої пам'яті, слот для карт MicroSD, 3-мегапіксельну основну і 1,3-мегапіксельну фронтальну камери, стандартний набір радіо модулів та операційну систему Android 4.4 KitKat.
ARTICLE

ss782 = Article.create! title: "Незабаром стартують продажі 110-дюймового телевізора Samsung ", user_id: 1, publish_date: 1.weeks.ago, content: <<-ARTICLE
Компанія Samsung офіційно повідомила про старт продаж свого 110-дюймового телевізора. Пристрій отримав роздільну здатність 4K і оцінений в 150 тисяч доларів. Телевізор буде доступний в різних регіонах світу, включаючи Європу.
Розміри новинки становлять 2,6х1,8 метра. За заявою виробника, девайс оснащений всіма необхідними, для сучасного користувача, функціями.
ARTICLE

shs = Article.create! title: "Голосовий помічник для ОС WP 8.1 - Microsoft Cortana (відео)", user_id: 2, publish_date: 1.weeks.ago, content: <<-ARTICLE
Ресурс UnleashThePhones опублікував відео, в якому демонструється робота ще не анонсованого голосового помічника для ОС Windows Phone 8.1 - Microsoft Cortana. 
На жаль, відео не розкриває всіх можливостей Cortana, а лише показує процес налаштування даного сервісу.
Очікується, що офіційна презентація Microsoft Cortana відбудеться на початку квітня (Конференція Build).
ARTICLE

ss22 = Article.create! title: "Grand Theft Auto: San Andreas відтепер доступна і для Windows Phone 8 ", user_id: 2, publish_date: 1.weeks.ago, content: <<-ARTICLE
Популярна комп'ютерна гра Grand Theft Auto: San Andreas поступово "окуповує" мобільні платформи. Наприкінці минулого місяця була представлена версія для ОС Android, сьогодні, для Windows Phone 8.
ARTICLE

z27 = Article.create! title: "В деяких регіонах Росії закрили доступ до ВКонтакті", user_id: 2, publish_date: 1.weeks.ago, content: <<-ARTICLE
На даний момент, в деяких регіонах Росії заблоковано доступ до соціальної мережі ВКонтакті. Раніше інтернет -провайдер Ростелеком посилався на технічний збій, але врешті-решт визнав, що доступ до ресурсу закритий за рішенням суду. Ми, як оператор звязку, були зобовязані це зробити, - розповів представник компанії.
ARTICLE