# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :post do |f|
  f.sequence(:title) { Faker::Lorem.sentence }
  f.sequence(:description) { Faker::Lorem.sentence }
  f.association :forum
end
