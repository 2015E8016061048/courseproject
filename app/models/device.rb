class Device < ActiveRecord::Base
  def Device.kindcollection
    kindcollect=Array.new
    i=0
    Device.select(:kind).distinct.each  do |m|
      kindcollect[i]=m.kind
      i+=1;
    end
    return kindcollect
  end
      
end
