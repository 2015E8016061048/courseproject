class DevicesController < ApplicationController
  def index
    if session[:user_id] == nil and session[:user_name] == nil
      redirect_to "/login"
    end
    if Device.kindcollection.include?  params[:k] 
      @devices = Device.where("kind = ?",params[:k])
    else
       @devices = Device.all
    end
   
    @myborrow= Array.new
    @remind=   Array.new
    @kinds=    Array.new
    i=0
    (Borrow.ungiveback session[:user_id]).each do |ugd|
      @myborrow[i]= ugd.device_id
      i+=1
    end
    @allborrow = Borrow.allungiveback
    
    @remind= (Borrow.ungiveback session[:user_id])
    @kinds= Device.kindcollection
    
    if params[:k] == "my"
      @devices = Device.find @myborrow
    elsif params[:k] == "available"
      @devices = Device.where("statement = '可用'")
    end
    
  end
  
  def new
  end
  
  def edit
    @device = Device.find(params[:id])
  end
  
  def update
    @device = Device.find(params[:id])
 
    if @device.update(device_params)
      flash[:notice] = "成功更新设备：#{@device.name} ！"
      redirect_to @device
    else
      render 'edit'
    end
  end
  
  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    flash[:notice] = "成功删除设备：#{@device.name} ！"
    redirect_to "/managedevices"
  end

  def create
    @device = Device.new(device_params)
 
    @device.save
    flash[:notice] = "成功添加设备：#{@device.name} ！"
    redirect_to @device
  end
  
  def show
    @device = Device.find(params[:id])
  end
  
  
  
  def managedevices
    @devices = Device.all
  end
  
  private
  def device_params
    params.require(:device).permit(:name, :kind,:description,:department,:statement,:k)
  end
  
end
