class AdminsController < ApplicationController
  http_basic_authenticate_with name: "superadmin", password: "superadmin",
  except: [:edit, :update,:logout,:login,:checklogin]
  
  def index
    
    @admins = Admin.all
  end
  
  def new
  end
  
  def edit
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
    @admin = Admin.find(params[:id])
  end
  
  def update
    if session[:admin_id] == nil and session[:admin_name] == nil
      redirect_to "/managerlogin"
    end
    
    @admin = Admin.find(params[:id])
    
    if  params[:admin][:name] != "" and (params[:passwd_confirm][:passwd_confirm].eql? params[:admin][:passwd]) and params[:admin][:passwd] != "" and params[:passwd_confirm][:passwd_confirm] != ""  and params[:admin][:passwd].length >=6  
      @admin.update(admin_params)
      session[:admin_name] = @admin.name
      flash[:notice] = "成功更新个人信息！"
      redirect_to "/manage"
    else
      flash[:warning] = "存在错误,请重输 !"
      render 'edit'
    end
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "成功删除用户：#{@admin.name} ！"
    redirect_to admins_path
  end
  
  def create
    if  params[:admin][:name] != "" and (params[:passwd_confirm][:passwd_confirm].eql? params[:admin][:passwd]) and params[:admin][:passwd] != "" and params[:passwd_confirm][:passwd_confirm] != ""  and params[:admin][:passwd].length >=6  
     
      @admin = Admin.new(admin_params)
      @admin.save
      flash[:notice] = "成功添加用户：#{@admin.name} ！"
      redirect_to @admin
    else
      flash[:warning] = "存在错误,请重输 !"
      render "/admins/new"
    end
  end
  
  def show
    @admin = Admin.find(params[:id])
  end
  
  def logout
    session[:admin_id] = nil
    session[:admin_name] = nil
    flash[:notice] = "成功退出！"
    redirect_to "/managerlogin"
  end
  def login
    if session[:admin_id] !=nil and session[:admin_name] != nil and session[:admin_name] != "" and session[:admin_id] !=""
      redirect_to "/manage"
    end
  end
  
  
  def checklogin
    @admin = Admin.where("name = ? and passwd = ?",  params[:name][:name],params[:passwd][:passwd]).take
    
    if @admin != nil and @admin != ""
      @currentadmin = @admin
      session[:admin_name] = @admin.name
      session[:admin_id] = @admin.id
      flash[:notice] = "#{@admin.name} 登录成功 ！"
      redirect_to "/manage"
    else
      flash[:warning] = "用户名或密码错误 ！"
      redirect_to "/managerlogin"
    end
  end
  
  private
  def admin_params
    params.require(:admin).permit(:name, :passwd)
  end
end
