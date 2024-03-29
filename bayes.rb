# Gender-prediction based on Naive bayes classifier

class Bayes

  # method for finding variance  
  def variance(ary)
    mean = (ary.inject(0.0) {|s,x| s + x}) / Float(ary.length)
    var  = (ary.inject(0.0) {|s,x| s + (x - mean)**2})/ Float(ary.length)
    return var, mean
  end
  
  # gaussian normalization processing (calculate probabilities)
  def pos_prob(w_var,w_mean,h_var,h_mean,h_input,w_input)
    pos_height = 1/(Math.sqrt(2*3.14*h_var)) * Math.exp( -((h_input - h_mean)**2)/(2*h_var))
    pos_weight = 1/(Math.sqrt(2*3.14*w_var)) * Math.exp( -((w_input - w_mean)**2)/(2*w_var))
    prod_pos   = pos_height * pos_weight
  end
  
  # prediction algorithm (compare probabilities generate results)
  def predict(ht,wt)
    ht =ht.to_i
    wt =wt.to_i
    
    arr_w_men   = User.connection.select_values("SELECT weight FROM users WHERE gender='male'")
    arr_h_men   = User.connection.select_values("SELECT height FROM users WHERE gender='male'")
    arr_w_women = User.connection.select_values("SELECT weight FROM users WHERE gender='female'")
    arr_h_women = User.connection.select_values("SELECT height FROM users WHERE gender='female'")
    
    arr_w_men 	= arr_w_men.map(&:to_i)
    arr_h_men 	= arr_h_men.map(&:to_i)
    arr_w_women = arr_w_women.map(&:to_i)
    arr_h_women = arr_h_women.map(&:to_i)
    
    # variance and mean calculation for men and women data
    w_var_m,w_mean_m = variance(arr_w_men)
    h_var_m,h_mean_m = variance(arr_h_men)
    w_var_w,w_mean_w = variance(arr_w_women)
    h_var_w,h_mean_w = variance(arr_h_women)
    
    # probability calculation
    p_m_women = pos_prob(w_var_w,w_mean_w,h_var_w,h_mean_w,ht,wt)
    p_m_men   = pos_prob(w_var_m,w_mean_m,h_var_m,h_mean_m,ht,wt)
    
    #comparison of probabilities for prediction
     if p_m_men > p_m_women
        return "Male"
     else
        return "Female"
     end
  end  
  
end
  

  

		


  