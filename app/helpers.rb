helpers do
  def check_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      redirect :'/'
    end
  end

  def get_item
    @item = Item.find_by(id: params[:id])
    redirect :'/dashboard' unless @item
  end

  def get_bucket
    @bucket = Bucket.find_by(id: params[:bucket_id])
    redirect :'/dashboard' unless @bucket
  end

  def toggle_status(item)
    if item[:status] == "new"
      item[:status] = "done"
    else
      item[:status] = "new"
    end
  end

  def update_bucket(item)
    item.bucket.updated_at = Time.now
    item.bucket.save
  end
end