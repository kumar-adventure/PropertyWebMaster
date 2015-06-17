class AdminContactsController < ApplicationController
  before_action :set_admin_contact, only: [:show, :edit, :update, :destroy]

  # GET /admin_contacts
  # GET /admin_contacts.json
  def index
    @admin_contacts = AdminContact.all
  end

  # GET /admin_contacts/1
  # GET /admin_contacts/1.json
  def show
  end

  # GET /admin_contacts/new
  def new
    @admin_contact = AdminContact.new
  end

  # GET /admin_contacts/1/edit
  def edit
  end

  # POST /admin_contacts
  # POST /admin_contacts.json
  def create
    @admin_contact = AdminContact.new(admin_contact_params)

    respond_to do |format|
      if @admin_contact.save
        format.html { redirect_to root_path, notice: 'Admin contact was successfully created.' }
        format.json { render :show, status: :created, location: @admin_contact }
      else
        format.html { render :new }
        format.json { render json: @admin_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_contacts/1
  # PATCH/PUT /admin_contacts/1.json
  def update
    respond_to do |format|
      if @admin_contact.update(admin_contact_params)
        format.html { redirect_to @admin_contact, notice: 'Admin contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_contact }
      else
        format.html { render :edit }
        format.json { render json: @admin_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_contacts/1
  # DELETE /admin_contacts/1.json
  def destroy
    @admin_contact.destroy
    respond_to do |format|
      format.html { redirect_to admin_contacts_url, notice: 'Admin contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_contact
      @admin_contact = AdminContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_contact_params
      params.require(:admin_contact).permit(:email, :name, :contact_no, :message)
    end
end
