class Todo < ApplicationRecord
  validates :title, presence: true

  def active
    self.completed = false
    save
  end

  def complete
    self.completed = true
    save
  end
end
