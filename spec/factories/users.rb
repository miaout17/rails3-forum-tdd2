# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.sequence :email do |n|
    "person#{n}@example.com"
  end
  f.password "123456"
end
