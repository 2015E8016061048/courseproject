class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
 
    if @user.update(user_params)
      flash[:notice] = "成功更新用户：#{@user.name} 的信息！"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "成功删除用户：#{@user.name} ！"
    redirect_to users_path
  end
  def createuser
    @user = User.new(user_params)
    @user.save
    flash[:notice] = "用户：#{@user.name} 注册成功！  欢迎登录！"
    redirect_to "/login"
  end
  def create
    @user = User.new(user_params)
 
    @user.save
    flash[:notice] = "成功添加用户：#{@user.name} ！"
    redirect_to @user
  end
  
  def show
    @user = User.find(params[:id])
    
    @devices = Device.all
  end
  
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = "成功退出！"
    redirect_to "/login"
  end
  def login
    if session[:user_id] !=nil and session[:user_name] != nil and session[:user_name] != "" and session[:user_id] !=""
      redirect_to "/devices"
    end
  end
  
  def history
    @history = Borrow.where("user_id = ?",session[:user_id])
  end
  
  def checklogin
    @user = User.where("name = ? and passwd = ?",  params[:name][:name],params[:passwd][:passwd]).take
    
    if @user != nil and @user != ""
      @currentuser = @user
      session[:user_name] = @user.name
      session[:user_id] = @user.id
      flash[:notice] = "#{@user.name} 登录成功 ！"
      redirect_to "/devices"
    else
      flash[:warning] = "用户名或密码错误 ！"
      redirect_to "/login"
    end
  end
 
  def signup
  end
  private
  def user_params
    params.require(:user).permit(:name, :passwd)
  end
    
end
