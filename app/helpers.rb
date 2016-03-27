helpers do
  def check_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      redirect :'/'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def change_username(username)
    check_user
    unless @user.username == username
      @user.username = username
      if @user.save
        return "SUCCESS!"
      else
        return "USERNAME IS TAKEN"
      end
    end
  end

  def change_password(old_password, new_password, confirmed_password)
    check_user
    nil_count = 0
    passwords = [old_password, new_password, confirmed_password]

    passwords.each do |password| 
      if password == ""
        nil_count += 1
      end
    end
    if (1..2).include?(nil_count)
      return "PASSWORD FIELDS INCOMPLETE"
    elsif nil_count == 0

      old_password_verified = @user.password == old_password
      new_passwords_confirmed = new_password == confirmed_password

      if old_password_verified and new_passwords_confirmed
        @user.password = new_password
        @user.save
        return "SUCCESS!"
      elsif !old_password_verified and new_passwords_confirmed
        return "OLD PASSWORD INCORRECT"
      else
        return "NEW PASSWORD DOES NOT MATCH CONFRIMED PASSWORD"
      end

    end
    
  end

  def reset_session_settings
    session[:settings_username_update] = nil
    session[:settings_password_update] = nil
  end

  def get_item
    @item = Item.find_by(id: params[:id])
    redirect :'/dashboard' unless @item
  end

  def get_bucket
    @bucket = Bucket.find_by(id: params[:bucket_id])
    redirect :'/dashboard' unless @bucket
  end

  def update_bucket(item)
    item.bucket.updated_at = Time.now
    item.bucket.save
  end

  def toggle_status(item)
    if item[:status] == "new"
      item[:status] = "done"
    else
      item[:status] = "new"
    end
  end

end