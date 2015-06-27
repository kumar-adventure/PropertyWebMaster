class PropertiesController < ApplicationController
  protect_from_forgery :except => [:remove_image, :map_block]
  before_action :set_property, only: [:show, :edit, :update, :destroy, :smart_post, :smart_post_invite, 
    :edit_step_1, :edit_step_2 ]
  before_filter :authenticate_user!, only: [:new, :create]

  def translate_to_chinese
    address = params[:address]

    #data = RestClient.get("http://translate.google.com/translate_a/t?client=t&text=" + address.gsub(" ", "%20") + "&hl=en&sl=en&tl=zh&ie=UTF-8&oe=UTF-8&multires=1&otf=1&ssel=3&tsel=3&sc=1")
    #puts data 
    #render text: data.split("\"")[1] 
    res = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(address)}&language=zh-tw&result_type=point_of_interest&key=AIzaSyDaIjKgBMRqs-x-6wEvKEp4g1LTYaHdg94")

   res = JSON.parse(res)
   render text: res["results"].first["formatted_address"]
  end
  def temp_image

  end

  def add_temp_invitee
    TempContactRequest.create(
      user_id: current_user.id,
      property_id: params[:id],
      status: 'pending'
    )
    render json: {}
  end

  def add_map_invitee
    TempContactRequest.create(
      user_id: params[:user_id],
      property_id: params[:id],
      status: 'pending'
    )
    render json: {}
  end

  def remove_temp_invitee
    contact_request = TempContactRequest.find_by_id params[:id]
    contact_request.destroy if contact_request
    render json: {}
  end

  def map_block
    @lat = params[:lat]
    @lng = params[:lng]
    @zoom = params[:zoom]

    params[:address] = params[:address].present? ? params[:address] : 'Hong Kong'
    
    if params[:address].present?
      @properties = Property.near(params[:address]).where.not("latitude is null or longitude is null")
    else
      @properties = Property.where.not("latitude is null or longitude is null")
    end
    if params[:sort_by].present?
      @properties = @properties.order('created_at DESC') if params[:sort_by] == 'date'
      @properties = @properties.sort_by{|p| p.price} if params[:sort_by] == 'price'
    end
    #if params[:address] != ''
      @loc = Geocoder.search(params[:address]).first
    #else
    #  @loc = nil
    #end
    render layout: false
  end

  def get_properties
    @properties = Property.near([params[:lat], params[:lng]], 0).where.not("latitude is null or longitude is null")
  end

  def map
    @search_key = params[:address]
    @search_key = "Hong Kong" if @search_key.blank?
    
    if current_user
      UserSearch.create(
        user_id: current_user.id,
        query: params[:address],
        listing_type: params[:listing_type],
        property_type: params[:property_type],
        no_of_rooms: params[:no_of_rooms],
        min_budget: params[:from_budget],
        max_budget: params[:to_budget]        
      )
    end
    
    @loc = Geocoder.search(@search_key).first
    #@properties = Property.near(@loc)
    #if @search_key == ''
    #  @properties = Property.where.not("latitude is null or longitude is null")
    #else
    #  @properties = Property.near(params[:address]).where.not("latitude is null or longitude is null")
    #  @properties = Property.where.not("latitude is null or longitude is null")
    #else
    #  @properties = Property.near(@loc)
    #end

   
    #@bounds = @properties.collect{|property| [property.latitude, property.longitude] if property.latitude &&  property.longitude }
    #@bounds = @bounds.uniq
    #@bounds = @bounds - [ nil ]
    
    #filtered_properties = Array.new

    #@properties.each do |prop|
    #  filtered_properties.push prop if prop.filter_search(params[:listing_type], params[:property_type], params[:from_budget], params[:to_budget], params[:no_of_rooms] )
    #end
    
    #@properties = filtered_properties

    if params[:list_view]
      render 'list'
    else
      render 'map'
    end
  end

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all.order("created_at desc").limit(9)
  end

  def custom_contact_form    
    render layout: nil
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    PropertyVisited.create(
      user_id: current_user.id,
      property_id: params[:id]
    ) if current_user
    @contact_request = ContactRequest.new
  end

  # GET /properties/new
  def new
    @property = Property.new
    @property_image = @property.property_images.build
  end

  # GET /properties/1/edit
  def edit
  end

  def smart_post
    @related_searches = Array.new
    @related_searches += UserSearch.where(listing_type: "Sale", property_type: @property.property_type) if @property.available_for_sale
    @related_searches += UserSearch.where(listing_type: "Rent", property_type: @property.property_type) if @property.available_for_rent
    @related_users = (@related_searches.collect(&:user).uniq)[0..5] - [current_user]
  end

  def smart_post_invite
    params[:user_ids].each do |user_id|
      ContactRequest.create(
        note: params[:content],
        from_user_id: current_user.id,
        to_user_id: user_id,
        property_id: @property.id
      )
    end if params[:user_ids] && params[:user_ids].class == Array 

    redirect_to @property
  end
  
  def rental_agreement
   render layout: nil 
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    @property.posting_local = cookies[:language]
    @property.user_id = current_user.id
    data = render_to_string( :action => :rental_agreement, layout: nil )
    contract_file = File.open("public/#{@property.title}.docx", "w"){|f| f << data }

  
    @property.agreement= File.new("public/#{@property.title}.docx")

    if @property.save
      redirect_to fileupload_property_url(@property)
    else
      render action: :new
    end
  end

  def fileupload
    @property = Property.find params[:id]

    @property.update_column(:step_1, true)
    @property.update_column(:step_2, true)
  end
 
  def property_image
    @property = Property.find params[:id]

    if params[:property]
      @upload = PropertyImage.new(
        property_id: @property.id,
        photo: params[:property][:upload]
      )

      respond_to do |format|
        if @upload.save
          format.html {
            render :json => [@upload.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
          format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload.photo.url }
        else
          format.html { render action: "new" }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    else
      image_collection = @property.property_images.collect{|img| {name: img.photo_file_name, size: img.photo_file_size, url: img.photo.url, 
	thumbnailUrl: img.photo.url, deleteUrl: "/properties/16/remove_image?image_id=#{img.id}", deleteType: "DELETE"} }
      respond_to do |format|
        format.json { render json: {files: image_collection} }
      end
    end

  end

  def remove_image
    @upload = PropertyImage.find(params[:image_id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end 
  end

  def edit_step_1
    if @property.available_for_sale? && @property.available_for_rent?
      render :common_form
    elsif @property.available_for_sale?
      render :sale_form
    elsif @property.available_for_rent?
      render :rent_form
    end
  end

  def edit_step_2

  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    @property.posting_local = cookies[:language]
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_update_url, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:title, :short_desc, :price, :property_for, :landmark, :facing,
                                       :location, :property_in, :total_no_of_floors, :bed_rooms,
                                       :total_rooms, :bathrooms, :parking, :flooring, :furnishing,
                                       :open_for_inspection, :address, :city, :district, :zipcode,
                                       :available_from, :photo, :contact_hours, :long_desc, :property_type, 
                                       :rent, :saleable_area, :gross_area, :vacant_or_possession, :landlord_name, 
                                       :hkid_no, :furniture_and_fittings, :electronic_appliences, :no_of_keys,
                                       :other_assets, :terms_and_conditions_of_sale, :accept_short_lease, :accept_shared_rent,
                                       :require_income_proof, :deposite, :tenancy_terms, :fixed_period, :break_clause_notice,
                                       :availablity_date, :rent_inclusive_of_management_fee, :rent_inclusive_of_gov_rent,
                                       :meter_reading, :rent, :property_type, :available_for_rent, :available_for_sale,
                                       :balcony, :rooftop, :clubhouse, :swiming_pool, :gym_room, :shuttle_bus, :sea_view,
                                       :building_name, :flat, :street, :year_build, :private_garden, :pet_allowed, :expiration_date,
                                       :parking_garage, :private_parking_space, property_images_attributes: [:id, :photo, :_destroy]
      )
    end

    def property_update_url
      if @property.step_1 == false
        @property.update_attribute(:step_1, true)
        new_property_path
      elsif @property.step_1 == true && @property.step_2 == false
        @property.update_attribute(:step_2, true)
        edit_step_1_property_path(@property)
      elsif @property.step_2 == true && @property.step_3 == false
        @property.update_attribute(:step_3, true)
        edit_step_2_property_path(@property)
      elsif @property.step_3 == true && @property.step_4 == false
        @property.update_attribute(:step_4, true)
        smart_post_property_path(@property)        
      elsif @property.step_4 == true && @property.step_5 == false
        property_path(@property)   
      end
    end
end
                                       

