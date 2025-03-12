class EntriesController < ApplicationController

  def new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["user_id"] = current_user
      if @entry.save
        redirect_to place_path(@entry.place_id)
      else
        render :new
      end
    else
      flash["notice"] = "Login first."
    end
  end

  def index
    @entries = current_user.entries
  end

end
