class CommentsController < ApplicationController
  def index
    @comments = Comment.hash_tree
  end

  def new
    if params[:parent_id].to_i > 0
      card_id = Comment.find(params[:parent_id]).card_id
    else
      card_id = params[:card_id]
    end
    @comment = Comment.new(
        parent_id: params[:parent_id],
        user_id: session[:user_id],
        card_id: card_id
    )
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to card_url(Card.find(comment_params[:card_id]))
    else
      render 'new'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:title, :body, :user, :card, :card_id, :user_id)
    end
end