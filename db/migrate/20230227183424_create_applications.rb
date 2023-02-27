class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :job_title
      t.string :description
      t.integer :user_id
      t.integer :job_id
      t.timestamps
    end
    
  end
end
