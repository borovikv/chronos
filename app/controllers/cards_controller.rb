class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :set_group, :set_order]

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def set_group
    @card.group = Group.find(params[:group_id])
    respond_to do |format|
      if @card.save
        format.html { redirect_to board_url(Group.find(params[:group_id]).board), notice: 'Card was successfully moved'}
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def set_order
    puts params[:data]
    data = params[:data]
    data.each { |key, value|
      puts 'key', key
      card = Card.find(key)
      card.order = value
      card.save
    }
    respond_to do |format|
      format.html { redirect_to board_url(@card.group.board), notice: 'Card was successfully moved'}
      format.json {head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      c_params = params.require(:card).permit(:text, :group_id)
      text = c_params[:text]
      html = Kramdown::Document.new(text).to_html

      group = Group.find(c_params[:group_id])

      title = get_title_from text

      {text: text, html: html, group: group, title: title}
    end

    def get_title_from(text)
      title = 'Title'
      text.split(/[\n\r]+/).each { |line|
        if line
          title = line
          break
        end
      }
      title
    end

end
