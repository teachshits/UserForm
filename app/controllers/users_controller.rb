# encoding: utf-8

class UsersController < ApplicationController

  # GET /
  def enter
    @user = User.find_by_id(session[:user_id])
    
    respond_to do |format|
      if @user
        format.html { redirect_to @user } # Юзер уже в сессии -> страница юзера
      else
        @user = User.new
        format.html # Страница входа
      end  
    end  
  end


  # GET /users/1
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  # POST /users
  def create
    @reg_user = User.find_by_name(params[:user][:name])

    if @reg_user 
      session[:user_id] = @reg_user.id
      redirect_to @reg_user, notice: "Этот пользователь уже был в базе." 
      return # Такой юзер уже в базе -> в сессию и на его страницу, выход из метода
    end

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save # Новый юзер прошел валидации -> в сессию, и на его страницу
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: "Пользователь был успешно создан." }
      else # Валидации не пройдены -> входная страница, ошибки
        format.html { render action: "enter" } 
      end
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Выход из пользователя
  def logout
    @user = User.find(params[:id])
    session[:user_id] = nil

    respond_to do |format|
      format.html { redirect_to enter_url }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
