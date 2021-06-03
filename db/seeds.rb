user = User.create!(name: 'geezy', email: '123@mail.com', password: '123123', password_confirmation: '123123')

10.times do
  todo = user.todos.create!(title: Faker::Lorem.word)

  rand(100).times do
    todo.items.create!(name: Faker::Lorem.word, done: [true, false].sample)
  end
end
