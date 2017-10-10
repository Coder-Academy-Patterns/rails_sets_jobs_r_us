json.extract! job, :id, :company_id, :front_end, :back_end, :title, :description, :created_at, :updated_at
json.url job_url(job, format: :json)
