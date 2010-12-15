class AddRunnerSexToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :runner_sex, :string
  end

  def self.down
    remove_column :schedules, :runner_sex
  end
end
