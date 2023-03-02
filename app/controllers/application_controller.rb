class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'

    get '/jobs' do
        jobs = Job.all.order(:created_at)
  
        jobs.to_json
    end

    get '/jobs/:id' do
        job = Job.find(params[:id]) 
        job.to_json(include: {applications: {include: :user}})
    end

    post '/jobs' do
        begin
            job = Job.create!(
            title: params[:title],
            description: params[:description],
            company: params[:company],
            location: params[:location],
            salary: params[:salary]
            )
            { success: true, message: "Job created", job: job }.to_json
          rescue ActiveRecord::RecordInvalid => e
            status 422
            { success: false, error: e.record.errors.full_messages }.to_json
          rescue => e
            status 500
            { success: false, error: e.message }.to_json
          end
    end

    patch '/jobs/:id' do
        begin
            job = Job.find(params[:id])
            job.update!(params)
          { success: true, message: "Job updated", job: job }.to_json
        rescue ActiveRecord::RecordNotFound
          status 404
          { success: false, error: "Job not found" }.to_json
        rescue ActiveRecord::RecordInvalid => e
          status 422
          { success: false, error: e.record.errors.full_messages }.to_json
        rescue => e
          status 500
          { success: false, error: e.message }.to_json
        end
    end

    delete '/jobs/:id' do
        begin
            job = Job.find(params[:id])
            job.destroy
            { success: true, message: "Job deleted" }.to_json
          rescue ActiveRecord::RecordNotFound
            status 404
            { success: false, error: "Job not found" }.to_json
          rescue => e
            status 500
            { success: false, error: e.message }.to_json
          end
    end

    get '/users' do
        users = User.all
  
        users.to_json
    end

    get '/users/:email' do
        user = User.find_by(email: params[:email]) 
        user.to_json
    end

    post '/users' do
      begin
          user = User.create!(
            name: params[:name],
            email: params[:email],
            rank: "applicant",
            password: params[:password]
          )
          { success: true, message: "User created", user: user }.to_json
        rescue ActiveRecord::RecordInvalid => e
          status 422
          { success: false, error: e.record.errors.full_messages }.to_json
        rescue => e
          status 500
          { success: false, error: e.message }.to_json
        end
    end

    get '/applications' do
        applications = Application.all.order(:created_at)

        applications.to_json
    end

    get '/applications/:id' do
        begin
            application = Application.find(params[:id])
            application.to_json
        rescue ActiveRecord::RecordNotFound
            status 404
            { error: "Application not found" }.to_json
        end
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
        begin
            application = Application.create!(
              applicant_name: params[:applicant_name],
              job_title: params[:job_title],
              description: params[:description],
              user_id: params[:user_id],
              job_id: params[:job_id]
            )
            { success: true, message: "Application created", application: application }.to_json
          rescue ActiveRecord::RecordInvalid => e
            status 422
            { success: false, error: e.record.errors.full_messages }.to_json
          rescue => e
            status 500
            { success: false, error: e.message }.to_json
          end
    end

    patch '/applications/:id' do
        begin
          application = Application.find(params[:id])
          application.update!(params)
          { success: true, message: "Application updated", application: application }.to_json
        rescue ActiveRecord::RecordNotFound
          status 404
          { success: false, error: "Application not found" }.to_json
        rescue ActiveRecord::RecordInvalid => e
          status 422
          { success: false, error: e.record.errors.full_messages }.to_json
        rescue => e
          status 500
          { success: false, error: e.message }.to_json
        end
    end

    delete '/applications/:id' do
        begin
            application = Application.find(params[:id])
            application.destroy
            { success: true, message: "Application deleted" }.to_json
          rescue ActiveRecord::RecordNotFound
            status 404
            { success: false, error: "Application not found" }.to_json
          rescue => e
            status 500
            { success: false, error: e.message }.to_json
          end
    end

end