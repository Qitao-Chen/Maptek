class AccountsController < ApplicationController
  def login

  end

  def register
    @account = Account.new
  end

  # def test
  #   email = params[:email].strip
  #     role = params[:role].strip
  #     if role.to_i == 0
  #       @str2=email
  #       end
  # end


def  create_account
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

  #setting account status, admin can control it。 1 is non-activated, 0 is activated.
  #set role , 0 is customer, 1 is admin , 2 is super-admin. design this for super-admin to specify admin.
  # Limit registration authority， only super-admin can specify admin.
  status = 0
  if role.to_i == 1
    status = 1
  end

  # get data from database for next step check the email address and name was registered or not.
  account_n = Account.find_by(name:name)
  account_e = Account.find_by(email:email)

  # create an account
  @account = Account.new

  if name.blank? || email.blank?

    redirect_to "/accounts/register", notice: ": user name or email can not empty"
  elsif  account_n
    redirect_to "/accounts/register", notice: ": user name has been registered"

    puts "account1"
  elsif  account_e
    redirect_to "/accounts/register", notice: ": email address already  be registered"

    puts "account2"
  elsif  name.length >10
    redirect_to "/accounts/register", notice: ": User name can not longer than 10 letters"
  elsif password.blank? || password_confirmation.blank?

    redirect_to "/accounts/register", notice: ": password empty!"

  elsif  password != password_confirmation
    redirect_to "/accounts/register", danger: ": The passwords were not entered in the same way"
  else
    @account.status = status
    @account.name = name
    @account.email = email
    @account.password = password
    @account.role = role
    boolean = @account.save
    if boolean
      flash[:notice] =  "Register successful"
       redirect_to "/homepage/test"
    else
      flash[:notice] =  "Register failed"
      render :register
    end
  end
end

  def create_login
    # take info from login page params
    email = params[:email].strip
    password_html = params[:password].strip
    # check the input area empty or not

    # if email.blank? || password_html.blank?
    #   flash[:Notice] = ": Email address or password empty"
    #   redirect_to "/accounts/login"
    # end
    #use email to find user
    account = Account.find_by(email:email)

    #if the user exist
    if account
      #user is admin，status active，password correct，then login successful
      if account.role == 1 && account.status == 0
        #compare input password to database password
        if account.password.to_s == password_html
          redirect_to  "/administrater/main", notice: "Login successful"
        else
          flash.notice = "User name or password incorrect!"
          redirect_to "/accounts/login", notice: ": User name or password incorrect!"
        end
        #if user is admin，status non-active，need active by super-admin
      elsif account.role == 1 && account.status == 1
        flash.notice = ": account not activate, please contact super-admin"
        redirect_to "/accounts/login"
        #normal user, password correct. login
      else
        if account.password.to_s == password_html
          # session[:account_id] = account.id
          flash.notice = "Login successfully！"
          redirect_to "/homepage/test"
        else
          flash.notice = "User name or password incorrect!"
          render :login
        end
      end
      #if user not exist, notice user to register
     elsif
       email.blank? || password_html.blank?
        flash[:Notice] = ": Email address or password empty"
        redirect_to "/accounts/login"

      # flash.notice = "user not exist, register now"
      else
      redirect_to "/accounts/login", Notice: ": User not exist, register now !"
    end
    end




  # def test
  #   email = params[:account][:email]
  #   role = params[:account][:role]
  #   if role.to_i == 0
  #     @str2=email.to_s
  #   end
  # end
  def test
  end
end

