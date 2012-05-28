class LoginsController < ApplicationController

  def destroy
    # session[:login_id] = nil
    reset_session
    redirect_to root_url, notice: "See ya!"
  end
  
  def new
    
  end

  def create
    logger.debug "Helllllooooooooooo!"
    
    user = User.find_by_name(params[:name].downcase)
    if user
      if user.authenticate(params[:password])
        session[:login_id] = user.id
        redirect_to root_url
      else
        flash[:notice] = "Wrong Password"
        redirect_to root_url
      end
    else
      flash[:notice] = "Unknown Login"
      redirect_to root_url
    end
  end

end
