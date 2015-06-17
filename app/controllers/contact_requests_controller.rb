class ContactRequestsController < ApplicationController
  before_action :set_contact_request, only: [:show, :edit, :update, :destroy, :accept, :reject, 
                :rental_agreement, :generate_rental_agreeement, :agreement, :generate_rental_agreement]

  def rental_agreement
   render layout: nil 
  end

  def generate_rental_agreement
    data = render_to_string( :action => :rental_agreement, layout: nil )
    File.open("public/#{@contact_request.property.title}.docx", "w"){|f| f << data }
    send_file "public/#{@contact_request.property.title}.docx"
  end

  def agreement
    data = render_to_string( :action => :rental_agreement, layout: nil )
    contract_file = File.open("public/#{@contact_request.property.title}.docx", "w"){|f| f << data }
    #send_file "public/#{@contact_request.property.title}.docx"
  
    message = ContactMessage.create!(
      content: "#{current_user.name} has sent you the agreement document for review",
      user_id: current_user.id,
      contact_request_id: @contact_request.id,
      agreement: File.new("public/#{@contact_request.property.title}.docx")
    )
    @contact_request.update_attribute(:agreement_letter_sent, true)

    flash[:message] = "Agreement document sent successfully"
    redirect_to @contact_request
    
  end

  # GET /contact_requests
  # GET /contact_requests.json
  def index
    @contact_requests = ContactRequest.all
  end

  # GET /contact_requests/1
  # GET /contact_requests/1.json
  def show
    @contact_message = ContactMessage.new
  end

  def bulk
    user = User.find_by_email params[:email]

    unless user
      password_str = SecureRandom.hex
      user = User.create(
        email: params[:email],
        password: password_str,
        password_confirmation: password_str,
        name: params[:name],
        address: params[:address],
        contact_no: params[:contact_no]
      )
    end
    
    if params[:store_to_profile]
      current_user.update_attribute(:phone_no, params[:contact_no])
    end

    contact_requests = TempContactRequest.where(user_id: current_user.id)
    contact_requests.each do |c_request|
      property = c_request.property

      cr = ContactRequest.create(
        preffered_time: nil,
        note: params[:note],
        from_user_id: user.id,
        to_user_id: property.user.id,
        status: "pending",
        property_id: property.id
      )

      ContactMessage.create(
        contact_request_id: cr.id,
        user_id: user.id,
        content: params[:note]
      )

      visit = PropertyVisited.find_by_user_id_and_property_id(user.id, property.id)
      visit.update_attribute(:status, 'Meeting request sent.')
      TempContactRequest.where(user_id: current_user.id).delete_all
    end
    redirect_to visits_users_path

  end

  def accept
    @contact_request.update_attribute(:status, "accepted")
    redirect_to contact_requests_path
  end

  def reject
    @contact_request.update_attribute(:status, "rejected")
    redirect_to contact_requests_path
  end
  # GET /contact_requests/new
  def new
    @contact_request = ContactRequest.new
  end

  # GET /contact_requests/1/edit
  def edit
  end

  # POST /contact_requests
  # POST /contact_requests.json
  def create
    @contact_request = ContactRequest.new(contact_request_params)

    respond_to do |format|
      if @contact_request.save
        format.html { redirect_to @contact_request.property, notice: 'Contact request was successfully posted.' }
        format.json { render :show, status: :created, location: @contact_request }
      else
        format.html { render :new }
        format.json { render json: @contact_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_requests/1
  # PATCH/PUT /contact_requests/1.json
  def update
    respond_to do |format|
      if @contact_request.update(contact_request_params)
        format.html { redirect_to @contact_request, notice: 'Contact request was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_request }
      else
        format.html { render :edit }
        format.json { render json: @contact_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_requests/1
  # DELETE /contact_requests/1.json
  def destroy
    @contact_request.destroy
    respond_to do |format|
      format.html { redirect_to contact_requests_url, notice: 'Contact request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_request
      @contact_request = ContactRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_request_params
      params.require(:contact_request).permit(:preffered_time, :note, :from_user_id, :to_user_id,
                                              :property_id, :status)
    end
end
