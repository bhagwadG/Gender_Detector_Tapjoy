module UsersHelper
  
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.gender,         :alt => h(user.gender),
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
