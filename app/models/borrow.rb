class Borrow < ActiveRecord::Base
  def Borrow.ungiveback userid
    ugdevices = Borrow.where("user_id= ? and date( givebacktime) = date('1990-01-01') ",userid)
    return ugdevices
  end
  
  def Borrow.allungiveback
    allugdevices = Borrow.where("date( givebacktime) = date('1990-01-01') ")
    return allugdevices
  end
  
  def Borrow.devicescount
    counts = Hash.new
    Borrow.select(:device_id).each do |c|
      if counts.include? c.device_id
        counts[c.device_id] = counts[c.device_id]+1
      else
        counts[c.device_id] = 1
      end
    end
    return counts
  end
end
