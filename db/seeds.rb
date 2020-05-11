# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

events_title = ["Mountain Bike","Beach Gym", "Street photograph", "Rock Gym", "Running Up", "Burn Yourself", "Let's Shovel!", "Kayaking on Charles", "Net Skywalker!", "Skydive Crazy",
                "Surf on Blue", "Camp Fish", "Grass Skiing", "Camp under Galaxy", "Skateboard, be cool!", "Central Skating", "Sketch", "Burn Fat!!", "Luke Skydiver!", "Family Skating", 
                "Just Golf", "Shadow", "Slide BMX", "Power!", "Kid Football", "Free Discussion", "Track Training", "Beach Running", "Desert Skydive", "Opera! Opera!"]
100.times do |i|
    name = Faker::Name.name
    User.create(
        name: name,
        email: Faker::Internet.email,
        password: '0' + name + '0'
    )

    Event.create(
        title: events_title[i%30],
        price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
        time: Faker::Date.in_date_period,
        place: "Boston",
        description: Faker::GreekPhilosophers.quote
    )
end
users = User.all
events = Event.all
users.each do |user|
    sample_events=events.sample(10)
    sample_events.each do |event|
        Participant.create(
            user_id: user.id,
            role: rand(4),
            event_id: event.id
        )
    end
end
events.each do |event|
    sample_users = users.sample(2)
    post = nil
    sample_users.each do |user|
        post = Post.create(
            author: user,
            event: event,
            content: Faker::GreekPhilosophers.quote,
            title: Faker::FunnyName.three_word_name
        )
    end
    sample_users.each do |user|
        Post.create(
            author: user,
            event: event,
            parent: post,
            content: Faker::GreekPhilosophers.quote,
            title: Faker::FunnyName.three_word_name
        )
    end
end