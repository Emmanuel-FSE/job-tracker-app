class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'

    before do
        headers 'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
                'Access-Control-Allow-Headers' => 'Content-Type'
    end

    use Rack::Cors do
        allow do
          origins ''
          resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
        end
    end

    get '/jobs' do
        jobs = Job.all.order(:created_at)
  
        jobs.to_json
    end

    get '/jobs/:id' do
        job = Job.find(params[:id]) 
        job.to_json(include: {applications: {include: :user}})
    end

    get '/users' do
        users = User.all
  
        users.to_json
    end

    get '/users/:email' do
        user = User.find_by(email: params[:email]) 
        user.to_json
    end

    get '/applications' do
        applications = Application.all.order(:created_at)

        applications.to_json
    end

    get '/jobs/applications/:id' do
        job = Job.find(params[:id])
        applications = job.applications.to_json
    end

    get '/users/applications/:id' do
        user = User.find(params[:id])
        applications = user.applications.to_json
    end

    post '/applications' do
        application = Application.create(
         applicant_name: params[:applicant_name],
         job_title: params[:job_title],
         description: params[:description],
         user_id: params[:user_id],
         job_id: params[:job_id]) 
        application.to_json
    end

    delete '/applications/:id' do
        application = Application.find(params[:id])
        application.delete
        "Deleted #{application.title}"
    end

end