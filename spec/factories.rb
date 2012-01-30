# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.gender                "male"
  user.weight                 180
  user.height                 6
end