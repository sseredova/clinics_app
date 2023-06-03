class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show edit update destroy download_pdf ]

  # GET /clinics or /clinics.json
  def index
    if not current_user 
      redirect_to new_user_session_path
    else
      
       @clinics = SearchClinicQuery.new
    
      page = params[:page]
    
      if params["search"]
        @search = params["search"]
        @clinics = @clinics.search(@search).page(page).per(10)
      else 
        @clinics = Clinic.all
        @clinics = @clinics.page(params[:page]).per(10)
        @clinics = @clinics.order(created_at: :asc)
      end
      
      respond_to do |format|
        format.html
        format.csv { send_data Clinic.to_csv, filename: "clinics-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
      end
      
    end
    
   
  end

  # GET /clinics/1 or /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @clinic = Clinic.new
  end

  # GET /clinics/1/edit
  def edit
    @clinic = Clinic.find(params[:id])
  end

  # POST /clinics or /clinics.json
  def create
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to clinic_url(@clinic), notice: "Clinic was successfully created." }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1 or /clinics/1.json
  def update
    
    @clinic = Clinic.find(params[:id])
    puts @clinic.inspect
    
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to clinic_url(@clinic), notice: "Clinic was successfully updated." }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1 or /clinics/1.json
  def destroy
    @clinic.destroy

    respond_to do |format|
      format.html { redirect_to clinics_url, notice: "Clinic was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def export_csv
        @clinics = Clinic.all
        
        respond_to do |format|
            
            format.csv do 
                response.headers['Content-Type'] = 'text/csv'
                response.headers['Content-Disposition'] = "attachment;filename=clinics.csv"
            end
        end
  end
  
  def download_pdf
        pdf = Prawn::Document.new
        pdf.text @clinic.name, size: 24, style: :bold
        pdf.move_down 20
        pdf.text "Address: #{@clinic.address}"
        pdf.text "Type: #{@clinic.category}"
        pdf.text "Rating: #{@clinic.rating}"
        pdf.text "Year: #{@clinic.year}"
        pdf.move_down 20
        pdf.text "Departments:", size: 16, style: :bold
        @clinic.departments.each do |department|
            pdf.text "- #{department.name}"
        end
        send_data(pdf.render, filename: "clinics.pdf", type: "application/pdf", disposition: "inline")
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
      # todo: add includes 
    end

    # Only allow a list of trusted parameters through.
    def clinic_params
      params.require(:clinic).permit(:name, :address, :image)
    end
end
