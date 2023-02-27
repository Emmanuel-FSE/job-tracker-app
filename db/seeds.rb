puts "🌱 Seeding data..."

users = []
10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    rank: "applicant"
  )
  users << user
end

20.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Job.field,
    company: Faker::Company.name,
    location: Faker::Address.city,
    salary: rand(100000..200000)
  )

  rand(1..3).times do
    user = users.sample
    Application.create!(
      applicant_name: user.name,
      description: Faker::Lorem.sentence,
      job_id: job.id,
      user_id: user.id
    )
  end
end

puts "🌱 Done seeding!"