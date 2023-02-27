class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'

    get '/jobs' do
        jobs = Job.all.order(:created_at)
  
        jobs.to_json
    end

    get '/applications' do
        applications = Application.all.order(:created_at)

        applications.to_json
    end

    get '/jobs/:id' do
        job = Job.find(params[:id]) 
        job.to_json(include: {applications: {include: :user}})
    end
end