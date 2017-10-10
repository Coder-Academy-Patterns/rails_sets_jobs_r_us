class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    @xero = Company.where(name: 'Xero')
    @xero_jobs = Job.where(company: @xero)

    @atlassian = Company.where(name: 'Atlassian')
    @atlassian_jobs = Job.where(company: @atlassian)

    @front_end_jobs = Job.where(front_end: true)
    @back_end_jobs = Job.where(back_end: true)

    # Intersection
    @full_stack_jobs = @front_end_jobs & @back_end_jobs
    # Complement
    @i_hate_back_end_jobs = @jobs - @back_end_jobs
    #@i_hate_back_end_jobs = Job.where.not(id: @back_end_jobs)

    # Union
    @xero_or_atlassian_jobs = @xero_jobs | @atlassian_jobs

    # Subset
    @finance_companies = Company.where(industry: 'finance')
    @finance_jobs = Job.where(company: @finance_companies)

    # Difference
    @non_finance_full_stack_jobs = @full_stack_jobs - @finance_jobs

    # Textual search
    @javascript_jobs = Job.where('description LIKE ?', '%javascript%')
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:company_id, :front_end, :back_end, :title, :description)
    end
end
