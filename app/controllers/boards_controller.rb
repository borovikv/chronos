class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy, :add_user, :remove_user, :manage]
  before_action :set_user, only: [:remove_user]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.where(user:@current_user).order(:name)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    session[:board_id] = @board.id
  end

  # GET /boards/new
  def new
    @board = Board.new(user: @current_user)
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /boards/1/add-user
  # POST /boards/1/add-user.json
  def add_user
    user = User.find_by(email: permission_params[:email])
    if user
      if @board.users.include? user
        respond_to do |format|
          format.html { redirect_to manage_board_path(@board), notice: "User #{user} already was added to board #{@board}"}
          format.json { head :no_content }
        end

      else
        puts 'permission_params-', params, permission_params
        @permission = Permission.new(board: @board, user: user, permission: permission_params['permission'])
        if @permission.save
          respond_to do |format|
            format.html { redirect_to manage_board_path(@board), notice: "User #{user} was successfully added to board #{@board}"}
            format.json { render json: user, status: :ok }
          end
        end

      end
    else
      respond_to do |format|
        format.html {redirect_to manage_board_path(@board)}
      end
    end
  end

  # DELETE /boards/1/remove-user
  # DELETE /boards/1/remove-user.json
  def remove_user
    @board.users.delete(@user)
    respond_to do |format|
      format.html { manage_board_path @board, notice: "User #{ user } was successfully deleted from board #{@board}." }
      format.js { render :remove_user }
      format.json { head :no_content }
    end
  end

  # GET /boards/:id/manage/
  def manage
    @permission = Permission.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :user_id)
    end

    def permission_params
      params.require(:permission).permit(:email, :permission)
    end

end
