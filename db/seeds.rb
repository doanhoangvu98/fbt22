User.create!(firstname: "Le Van",
  lastname: "Huynh",
  address: "59 Nguyen Luong Bang",
  phone: "0977469596",
  email: "huynhle@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456")

60.times do |n|
  firstname = "Le-#{n+1}"
  lastname = "Huynh-#{n+1}"
  address = "59 Nguyen Luong Bang"
  phone = "0977469596"
  email = "huynhle-#{n+1}@gmail.com"
  password = "123456"
  User.create!(firstname: firstname,
    lastname: lastname,
    address: address,
    phone: phone,
    email: email,
    password: password,
    password_confirmation: password)
end

Category.create!(name: "Trong nuoc")
Category.create!(name: "Ngoai nuoc")

30.times do |n|
  title  = Faker::Name.title,
  description = Faker::Lorem.paragraphs(2..8),
  price = "2990000",
  image = Faker::LoremPixel.image("255x267"),
  num_people = Random.rand(10),
  tour_start = Date.today,
  tour_finish =  Date.parse("2019-05-02")
  status = "0"
  category_id = 1
  Tour.create!(title: title,
    description: description,
    price: price,
    image: image,
    num_people: num_people,
    tour_start: tour_start,
    tour_finish: tour_finish,
    status: status,
    category_id: category_id)
end
