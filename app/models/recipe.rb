class Recipe < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :instructions
  validates :instructions, length:{minimum: 50}
end
