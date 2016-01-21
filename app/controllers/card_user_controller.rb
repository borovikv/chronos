class CardUserController < ApplicationController
  before_action :set_card, only: [:show, :destroy, :create, :new]
  before_action :set_user, only: [:create, :destroy]
  before_action :check_can_manage, only: [:create, :destroy]
  def show
  end

  def new
  end

  def create
    respond_to do |format|
      if @card.users << @user
        format.html { redirect_to show_card_user_url(@card), notice: "User #{@user} was added to card #{@card}"}
        format.js { render :show }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { head :no_content,  status: :unprocessable_entity  }
      end
    end
  end

  def destroy

    @card.users.delete(@user)
    respond_to do |format|
      format.html { redirect_to show_card_user_url(@card), notice: 'User was successfully deleted from card.' }
      format.js { render :destroy }
      format.json { head :no_content }
    end
  end


  private

  def set_card
    @card = Card.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def card_user_params
    params.permit(:user_id)
  end

  def check_can_manage
    unless @card.user_can_manage(@current_user)
      redirect_to board_url(@card.group.board)
    end
  end
end
