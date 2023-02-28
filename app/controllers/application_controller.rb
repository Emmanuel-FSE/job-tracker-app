class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'

    before do
        headers 'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
                'Access-Control-Allow-Headers' => 'Content-Type'
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

    get '/users/:id' do
        user = User.find(params[:id]) 
        user.to_json
    end

    get '/applications' do
        applications = Application.all.order(:created_at)

        applications.to_json
    end

end