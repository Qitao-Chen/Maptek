class AccountsController < ApplicationController
  def login

  end

  def register
    @account = Account.new
  end

  def test
  end


def create_account
  # params ={:account => :name}
  # params ={:account => :email}
  # params ={:account => :password}
  # params ={:account => :password_confirm}
  # params ={:account => :role}
  puts "test_2"
  name = params[:account][:name]
  email = params[:account][:email]
  password = params[:account][:password]
  password_confirmation = params[:account][:password_confirmation]
  role = params[:account][:role]
  # setting account status, admin can control it。 1 is non-activated, 0 is activated.

  status = 0
  if role.to_i == 1
    status = 1
  end

  # check the email address was registered or not from database.
  # account = Account.find_by(name:name)
  account = Account.find_by(email:email)

  # create an account
  @account = Account.new

  if name.blank? || email.blank?
    # flash.alert = "user name or email can not empty"
    flash[:notice] =  "user name or email can not empty"
    render :register
    puts "name or email"
  # elsif  account
  #   flash[:notice] =  "This name already be registered"
  #   puts "account1"
  elsif  account
    flash[:notice] = "email address already  be registered"
    # render :register
    puts "account2"
  elsif  name.length >10
    flash[:notice] =  "User name can not longer than 10 letters"
    # render :register
    puts "name"
  elsif  password != password_confirmation
    flash[:notice] =  "The passwords were not entered in the same way"
    # render :register
    puts "password"
  else
    @account.status = status
    @account.name = name
    @account.email = email
    @account.password = password
    @account.role = role
    boolean = @account.save
    puts "test_1"
    if boolean
      # flash[:notice] =  "Register successful"
      # puts "test"
      # redirect_to :login
    else
      puts "success"
      # flash[:notice] =  "Register failed"
      # render :register
    end
  end
end

  def create_login
    email = params[:email].strip
    password_html = params[:password].strip
    #use email to find user
    account = Account.find_by(email:email)
    #if the user exist
    if account
      #user is admin，status active，password correct，then login successful
      if account.role == 1 && account.status == 0
        #compare input password to database password
        if account.password.to_s == password_html
          flash.notice = "Login successful！"
          redirect_to  "/administrater/main"
        else
          flash.notice = "User name or password incorrect!"
          render :login
        end
        #if user is admin，status non-active，need active by super-admin
      elsif account.role == 1 && account.status == 1
        flash.notice = "account not activate"
        render :login
        #normal user, password correct. login
      else
        if account.password.to_s == password_html
          session[:account_id] = account.id
          flash.notice = "Login successfully！"
          redirect_to "/homepage/test"
        else
          flash.notice = "User name or password incorrect!"
          render :login
        end
      end
      #if user not exist, notice user to register
    else
      flash.notice = "user not exist, register now"
      render :login
    end

  end
end

