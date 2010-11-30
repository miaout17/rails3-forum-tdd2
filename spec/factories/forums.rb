# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :forum do |f|
  f.sequence(:title) { Faker::Lorem.sentence }
end
