class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    @finance_companies = Company.where(industry: 'finance')
    @productivity_companies = Company.where(industry: 'productivity')
    @ecommerce_companies = Company.where(industry: 'ecommerce')
    @utility_companies = Company.where(industry: 'utility')

    # All companies that have relationships to jobs,
    # and then ensure companies aren’t repeated with `distinct`
    @companies_hiring = Company.all.joins(:jobs).distinct

    # Companies in finance and also hiring (intersection)
    @finance_companies_hiring = @finance_companies & @companies_hiring

    # Companies either in the ecommerce or utility industries (union)
    @union_companies = @ecommerce_companies | @utility_companies

    # Companies with no jobs therefore not hiring (complement)
    @companies_not_hiring = Company.where.not(id: @companies_hiring)

    # Companies hiring excluding those in finance (difference)
    @non_finance_companies_hiring = @companies_hiring - @finance_companies
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :industry)
    end
end
