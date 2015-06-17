class PropertyCommentsController < ApplicationController
  before_action :set_property_comment, only: [:show, :edit, :update, :destroy]

  # GET /property_comments
  # GET /property_comments.json
  def index
    @property_comments = PropertyComment.all
  end

  # GET /property_comments/1
  # GET /property_comments/1.json
  def show
  end

  # GET /property_comments/new
  def new
    @property_comment = PropertyComment.new
  end

  # GET /property_comments/1/edit
  def edit
  end

  # POST /property_comments
  # POST /property_comments.json
  def create
    @property_comment = PropertyComment.new(property_comment_params)

    respond_to do |format|
      if @property_comment.save
        format.html { redirect_to @property_comment.property, notice: 'Property comment was successfully created.' }
        format.json { render :show, status: :created, location: @property_comment }
      else
        format.html { render :new }
        format.json { render json: @property_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /property_comments/1
  # PATCH/PUT /property_comments/1.json
  def update
    respond_to do |format|
      if @property_comment.update(property_comment_params)
        format.html { redirect_to @property_comment, notice: 'Property comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @property_comment }
      else
        format.html { render :edit }
        format.json { render json: @property_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /property_comments/1
  # DELETE /property_comments/1.json
  def destroy
    @property_comment.destroy
    respond_to do |format|
      format.html { redirect_to property_comments_url, notice: 'Property comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property_comment
      @property_comment = PropertyComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_comment_params
      params.require(:property_comment).permit(:user_id, :property_id, :content)
    end
end
