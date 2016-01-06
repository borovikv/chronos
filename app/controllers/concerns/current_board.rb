module CurrentBoard extend  ActiveSupport::Concern
  private

  def set_board
    begin
      @board = Board.find(session[:board_id])
    rescue
      @board = Board.find(1)
    end
  end
end