class Issue < ApplicationRecord
  has_many :articles

  def self.current_issue
    Issue.find_or_create_by(issued_at: current_issue_date)
  end

  def self.current_issue_date
    this_weeks_thursday = Date.current.beginning_of_week + 3
    return this_weeks_thursday if Date.current < this_weeks_thursday
    Date.current.next_week + 3
  end
end
