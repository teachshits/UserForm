# encoding: utf-8

class InterestsController < ApplicationController

  def create    
    @logged_user = session_user
    interest = Interest.find_by_title(params[:interest][:title])

    if interest 
      if @logged_user.interests.exists?(params[:interest]) 
        notice = "Такой интерес уже есть!"
      else
        @logged_user.interests << interest 
        notice = "Добавлен интерес '#{interest.title}'."
      end

      redirect_to @logged_user, notice: notice 
      return
    end

    @new_interest = @logged_user.interests.build(params[:interest])

    respond_to do |format|
      if @new_interest.save  
        @logged_user.interests << @new_interest
        format.html { redirect_to @logged_user, notice: "Создан интерес '#{@new_interest.title}'." }
      else
        @user = @logged_user 
        format.html { render 'users/show' }
      end
    end
  end 

  def destroy
    logged_user = session_user
    interest_to_del = Interest.find(params[:id])

    logged_user.interests.delete(interest_to_del)
    redirect_to logged_user, notice: "Был удален ваш интерес '#{interest_to_del.title}'."
  end
end