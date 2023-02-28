puts "🌱 Seeding data..."

users = []
10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    rank: "applicant",
    password: Faker::Internet.password(8, true, true)
  )
  users << user
end

20.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraphs(number: 2).join("\n\n"),
    company: Faker::Company.name,
    location: Faker::Address.city,
    salary: rand(100000..200000)
  )

  rand(1..3).times do
    user = users.sample
    Application.create!(
      applicant_name: user.name,
      description: Faker::Lorem.paragraphs(number: rand(1..3)).join("\n\n"),
      job_id: job.id,
      user_id: user.id,
      job_title: job.title
    )
  end
end

puts "🌱 Done seeding!"