class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.references :company, foreign_key: true
      t.boolean :front_end
      t.boolean :back_end
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
