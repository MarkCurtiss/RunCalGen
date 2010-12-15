class AddAgeToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :runner_age, :integer
  end

  def self.down
    remove_column :schedules, :runner_age
  end
end
