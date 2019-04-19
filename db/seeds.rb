User.create!(firstname: "Le Van",
  lastname: "Huynh",
  address: "59 Nguyen Luong Bang",
  phone: "0977469596",
  email: "huynhle@gmail.com",
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
