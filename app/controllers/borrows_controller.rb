class BorrowsController < ApplicationController
  
  def index
    @device = Device.find(params[:id])
    session[:device_id] = @device.id
  end  
    
  def borrow
    otime = Time.utc(params[:borrow].values[0],params[:borrow].values[1],params[:borrow].values[2],params[:borrow].values[3],params[:borrow].values[4])
    if otime.to_i-Time.now.to_i < 5*60
      flash[:warning] = "借出时间不得少于 5 分钟！"
      redirect_to "/devices"
    else
      @device = Device.find(session[:device_id])
      @borrow = Borrow.new
    
      @borrow.device_id = session[:device_id]
      @borrow.borrowtime = Time.now
      @borrow.givebacktime = "1990-01-01" 
      @borrow.ordertime = otime
      @borrow.user_id = session[:user_id]
    
      @borrow.save
      @device.update(statement: "借出")  
    
      flash[:notice] = "您成功借出设备:#{@device.name} ！请于#{otime.strftime("%Y-%m-%d %H:%M")}之前交还！"
      redirect_to devices_path
    end
  end
  
  
  def giveback
    @borrow = Borrow.where("user_id= ? and strftime('%Y-%m-%d',givebacktime) = strftime('%Y-%m-%d', '1990-01-01') and device_id = ?",session[:user_id],params[:id]).take
    @borrow.givebacktime = Time.now
    @borrow.save
    
    @device = Device.find(params[:id])
    @device.update(statement: "可用")
    
    flash[:notice] = "您成功归还设备：#{@device.name} ！"
    redirect_to devices_path
  end  
  
 
  def management
    @borrows = Borrow.all
  end
  
  def manage
    if session[:admin_id] ==nil and session[:admin_name] == nil 
      redirect_to "/managerlogin"
    end
  end
  
  def analyze
    @counts = Hash.new
    @counts = Borrow.devicescount
    @sum = 0
    @counts.values.each do |v|
      @sum = @sum + v 
    end
  end
  def search
    session[:q] = params[:borrow][:q]
    @devices = Device.where("name like '%#{params[:borrow][:q]}%' or department like '%#{params[:borrow][:q]}%'" )
    if @devices == nil or @devices == "" or @devices.length == 0
      flash[:warning] = "没有 #{params[:borrow][:q]} 的匹配结果！"
      redirect_to "/devices"
    end
  end
  def destroy
    @borrow = Borrow.find(params[:id])
    @borrow.destroy
    flash[:notice] = "成功删除借还信息 ！"
    redirect_to borrows_path
  end
  
  private
  def borrow_params
    params.require(:borrow).permit(:user_id, :device_id,:borrowtime,:ordertime,:givebacktime,:q,:borrow)
  end
  
end
