User.create!(firstname: "Le Van",
  lastname: "Huynh",
  address: "59 Nguyen Luong Bang",
  phone: "0977469596",
  email: "huynhle@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456")

User.create!(firstname: "Doan Hoang",
  lastname: "Vu",
  address: "Su pham",
  phone: "0328944440",
  email: "doanhuuanh4@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456")


30.times do |n|
  firstname = "Le-#{n+1}"
  lastname = "Huynh-#{n+1}"
  address = "59 Nguyen Luong Bang"
  phone = "0977469596"
  email = "huynhle-#{n+1}@gmail.com"
  picture = Faker::Avatar.image
  password = "123456"
  User.create!(firstname: firstname,
    lastname: lastname,
    address: address,
    phone: phone,
    email: email,
    picture: picture,
    password: password,
    password_confirmation: password)
end

Category.create!(name: "Trong nuoc")
Category.create!(name: "Ngoai nuoc")

Location.create!(name: "Ha Noi")
Location.create!(name: "Da Nang")

Travelling.create!(location_start_id: 1, location_end_id: 2)

30.times do |n|
  title  = Faker::Name.title
  description = Faker::Lorem.paragraphs(2..8)
  price = "299"
  image = Faker::LoremPixel.image("255x267")
  num_people = Random.rand(10)
  tour_start = Date.today
  tour_finish =  Date.parse("2019-05-02")
  status = 0
  category_id = 1
  travelling_id = 1
  Tour.create!(title: title,
    description: description,
    price: price,
    image: image,
    num_people: num_people,
    tour_start: tour_start,
    tour_finish: tour_finish,
    status: status,
    category_id: category_id,
    travelling_id: travelling_id)
end

100.times do |n|
  rating = Random.rand(1..5)
  content = Faker::Lorem.sentence(10)
  user_id = Random.rand(1..31)
  tour_id = Random.rand(1..30)
  Review.create!(rating: rating,
    content: content,
    user_id: user_id,
    tour_id: tour_id)
end

5.times do |n|
  content = Faker::Lorem.sentence(10)
  user_id = Random.rand(1..30)
  review_id = Random.rand(6..7)
  Comment.create!(content: content,
    reply_id: reply_id,
    user_id: user_id,
    review_id: review_id)
end

5.times do |n|
  content = Faker::Lorem.sentence(10)
  reply_id = Random.rand(1..5)
  user_id = Random.rand(1..30)
  review_id = Random.rand(6..7)
  Comment.create!(content: content,
    reply_id: reply_id,
    user_id: user_id,
    review_id: review_id)
end
