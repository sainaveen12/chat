class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index,:show]
  before_action :check_user,only: [:edit,:update,:destroy]

  # GET /friends or /friends.json
  def index
    @users = User.all.where.not(id: current_user) 
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  # def new
  #   @friend = Friend.new
  #   # @friend =current_user.friends.build()
    
  # end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def new
    @friend = Friend.new()
    @friend.requestor_id = current_user.id
    @friend.receiver_id = params[:id]
    @friend.status = "pending"
    # @friend =current_user.friends.build(friend_params)
    # @friend.user_id = current_user.id

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def check_user
    @friend =current_user.friends.find(params[:id])
    redirect_to friends_path,notice:"sorry u can't edit" if @friend.nil?
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:requestor_id,:receiver_id,:status)
    end
end
