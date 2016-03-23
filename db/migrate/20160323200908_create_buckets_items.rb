class CreateBucketsItems < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :rating, default: 0
      t.references :user
      t.timestamps null: false
    end

    create_table :items do |t|
      t.string :name
      t.string :status, default: "new"
      t.references :user
      t.references :bucket
      t.timestamps null: false
    end
  end
end