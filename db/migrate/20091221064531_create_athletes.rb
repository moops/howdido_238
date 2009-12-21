class CreateAthletes < ActiveRecord::Migration
  def self.up
    create_table :athletes do |t|
      t.String :first_name
      t.String :last_name
      t.String :city

      t.timestamps
    end
  end

  def self.down
    drop_table :athletes
  end
end
