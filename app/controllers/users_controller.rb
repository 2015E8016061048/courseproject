class UsersController < ApplicationController
  def index
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
    @users = User.all
  end
  
  def new
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
  end
  
  def edit
    if session[:admin_id] == nil and session[:admin_name] == nil and session[:user_id] == nil and session[:user_name] == nil
      redirect_to "/"
    end
    @user = User.find(params[:id])
  end
  
  def update
    if session[:admin_id] == nil and session[:admin_name] == nil and session[:user_id] == nil and session[:user_name] == nil
      redirect_to "/managerlogin"
    end
    @user = User.find(params[:id])
 
    if @user.update(user_params)  and params[:user][:name] != "" and (params[:passwd_confirm][:passwd_confirm].eql? @user.passwd) and params[:user][:passwd] != "" and params[:passwd_confirm][:passwd_confirm] != ""
      session[:user_name] = params[:user][:name]
      flash[:notice] = "成功更新用户：#{@user.name} 的信息！"
      redirect_to @user
    else
      flash[:warning] = "存在错误,请重输 !"
      render 'edit'
    end
  end
  
  def destroy
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "成功删除用户：#{@user.name} ！"
    redirect_to users_path
  end
  def createuser
    if (params[:passwd_confirm][:passwd_confirm].eql? params[:user][:passwd])
      @user = User.new(user_params)
      @user.save
      flash[:notice] = "用户：#{@user.name} 注册成功！  欢迎登录！"
      redirect_to "/login"
    else
      flash[:warning] = "两次输入密码不一致 !"
      render "signup"
    end
  end
  def create
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
    @user = User.new(user_params)
 
    @user.save
    flash[:notice] = "成功添加用户：#{@user.name} ！"
    redirect_to @user
  end
  
  def show
    if session[:admin_id] == nil and session[:admin_name] == nil and session[:user_id] == nil and session[:user_name] == nil
      redirect_to "/managerlogin"
    else
      @user = User.find(params[:id])
    end
   
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
    if session[:user_id] == nil and session[:user_name] == nil
      redirect_to "/login"
    end
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
