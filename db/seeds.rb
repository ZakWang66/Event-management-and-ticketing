# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

events_title = ["Mountain Bike","Beach Gym", "Street photography", "Rock Gym", "Running Up", "Burn Yourself", "Let's Shovel!", "Kayaking on Rivers", "Net Skywalker!", "Skydive Crazy",
                "Surf on Blue", "Camp Fish", "Grass Skiing", "Camp under Galaxy", "Skateboard, be cool!", "Central Skating", "Sketch", "Burn Fat!!", "Luke Skydiver!", "Family Skating", 
                "Just Golf", "Shadow", "Slide BMX", "Power!", "Kid Football", "Free Discussion", "Track Training", "Beach Running", "Desert Skydive", "Opera! Opera!"]

place_names = ["Boston", "New York", "Los Angeles", "San Francisco", "Washington D.C.", "Waltham", "Orlando", "Atlanta", "Philadelphia", "Chicago", "Houston", "Miami",
                "Seattle", "Austin", "Denver", "Detroit", "San Diego", "Portland", "Phoenix", "New Orleans", "Dallas", "Nashville"]

Golf = "Social is not our purpose, we just want to play golf, just golf. Have a peaceful and satisfied afternoon. So let's see you in the field. "

Opera = "Julius Caesar arrives to conquer Egypt—or will Cleopatra conquer him? Intrigue and passion abound in Handel’s greatest opera, which traces the epic political struggle and the transcendent love story that ignited an empire and anointed a queen. Don’t miss the opportunity to see this Baroque gem in a fully-realized, grand-scale installation that only Boston Lyric Opera can create."

BMX = "Get out there and have some fun. Meet new people, visit new places, take some pics for your instagram, pull new tricks, become a better person and maybe win something along the way. Lots has changed or is changing so double check and keep us posted. It's a crazy world we live in at the moment."

Football = "We want to build a youth football team, every kid has their own way to express the energy. Playing foot is definitely a good option for children. Come and join us, we have professional coaches and scientific training plan."

Discussion = "Do you want to talk? Talk to us. We are poeple to love discuss everything interesting in the world. We are good listener and also a good talker. Come and shrare your wisdom or your fool stories. We accept all!"

Surf = "Everyone can agree that everything related to surf is pretty cool. So are surf competitions. They’re fun to watch, they connect us to our surfing inspirations and it’s pretty nice to see people killing it at what they do best. But if you’re new to the world of surfing, understanding how the competition world works can be quite confusing. That is why I want to break it down for you."                

Camp = "At least once a week, the entire Treetops community takes part in a special event or activity —  laughing, playing, and celebrating together the spirit of Camp. Throughout the summer, campers, counselors, and staff alike look forward to these community-wide events."

Sketch = "Whether you plan to enter plein air events or not, the exercise of painting outdoors will almost certainly help you improve your paintings. So get yourself out there!"

Grasskii = "We started with a passion for snow skiing... but it sucks to stop in the summer. Join us for summer skiing!"

IceRink = "A great place to bring your family. It is Family oriented during public skating times. So get your family here and have a wonderful afternoon"

Skate = "One of the best skate contests in the world featuring a multi-part course, with team and individual competitions, as well as a sponsor village and outdoor music festival in the concert area, local food and drink vendors and public skate park."

MountainBike = "Wherever you live in the U.S., chances are good that there’s a mountain bike race near you. And if not, there’s no better excuse for a road trip than a race weekend, where you can expand your technical skills in unfamiliar terrain, challenge your fitness, and make new friends.
From leg-breaking climbs to ripping descents, mountain biking has it all. Whether you’re new to riding or an experienced veteran, there’s almost certainly a race out there for you. Here are several awesome mountain bike races to check out in 2020."

Gym = "We are an all-inclusive fitness health and wellness transformation center focusing on personal services to help clients reach their health and fitness goals. We offer several programs to accommodate various lifestyles; there’s something for everyone at every stage of their lives."

StreetPhotography = "“Seeing Beyond the Grey” and “Design Reflections” are two photo walk events that pull you in right away. Accompanied by Abbi Kemp and a colleague, the participants experience the event city through the eyes of accomplished Street Photographers. Bring a fully charged camera, good walking shoes and some spare batteries so you won’t miss any of those special moments."

Run = "Get ready to jump, climb, crawl, slide, run and laugh your way through this 5k! We have put together a variety of FUN obstacles including inflatables, color bombs, mazes, tire runs, potato sack races and more to keep you smiling the whole way through. Time is on your side with this event since it will not be officially timed but we will have a volunteer available at the finish line if you would like to check to see how you did. All ages are welcome to participate so bring a friend, significant other or the whole family to support a good cause!"

Shovel = "Do not shovel after eating or while smoking   Take it slow and stretch out before you begin   Shovel only fresh, powdery snow; it's lighter   Push the snow rather than lifting it   If you do lift it, use a small shovel or only partially fill the shovel" 

Kayaking = "There are few better ways to spend a couple hours or a full day for that matter, than in a kayak moving over water. Think portable fun with which you can explore a favorite or soon to be favorite spot. An experienced Instructor will share information about kayaking and recreational kayaks. You will leave knowing which type of kayak, paddle and PFD will best fit your needs, as well as, the skinny on local paddling destinations. Note: This course does not replace the need for on-water instruction."

Skydive = "Skydive is known for a fun and friendly atmosphere and our passion for the sport. We employ state-of-the-art training methods and use only the latest technology in skydiving equipment. We boast an excellent safety record, and all of our instructors are licensed through the United States Parachute Association (USPA). Each of our instructors has completed an intense training program to ensure the best possible methods of instruction."

NetWalk = "It is known for a fun and friendly atmosphere and our passion for the sport. We employ state-of-the-art training methods and use only the latest technology in walking equipment. We boast an excellent safety record, and all of our instructors are licensed. Each of our instructors has completed an intense training program to ensure the best possible methods of instruction."

description_list = [MountainBike, Gym, StreetPhotography, Gym, Run, Gym, Shovel, Kayaking, NetWalk, Skydive,
                    Surf, Camp, Grasskii, Camp, Skate, IceRink, Sketch, Gym, Skydive, IceRink,
                    Golf, Opera, BMX, Gym, Football, Discussion, Run, Run, Skydive, Opera]
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
        place: place_names[i%22],
        description: description_list[i%30]
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