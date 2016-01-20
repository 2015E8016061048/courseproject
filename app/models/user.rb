class User < ActiveRecord::Base
  def User.activeusers
    actusers = Array.new
    Borrow.allungiveback.each do |b|
      actusers << b.user_id
    end
    return actusers
  end 
end
