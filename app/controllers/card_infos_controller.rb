class CardInfosController < ApplicationController
  before_action :set_card_info, only: [:show, :edit, :update, :destroy]

  # GET /card_infos
  # GET /card_infos.json
  def index
    @card_infos = CardInfo.all
  end

  # GET /card_infos/1
  # GET /card_infos/1.json
  def show
  end

  # GET /card_infos/new
  def new
    @card_info = CardInfo.new
  end

  # GET /card_infos/1/edit
  def edit
  end

  # POST /card_infos
  # POST /card_infos.json
  def create
    @card_info = CardInfo.new(card_info_params)

    respond_to do |format|
      if @card_info.save
        format.html { redirect_to "/users/edit", notice: 'Card info was successfully created.' }
        format.json { render :show, status: :created, location: @card_info }
      else
        format.html { render :new }
        format.json { render json: @card_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_infos/1
  # PATCH/PUT /card_infos/1.json
  def update
    respond_to do |format|
      if @card_info.update(card_info_params)
        format.html { redirect_to @card_info, notice: 'Card info was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_info }
      else
        format.html { render :edit }
        format.json { render json: @card_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_infos/1
  # DELETE /card_infos/1.json
  def destroy
    @card_info.destroy
    respond_to do |format|
      format.html { redirect_to card_infos_url, notice: 'Card info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_info
      @card_info = CardInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_info_params
      params.require(:card_info).permit(:card_no, :expire_month, :expire_year, :ccv, :user_id)
    end
end
