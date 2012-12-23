class Task < ActiveRecord::Base
  attr_accessible :content, :time
  belongs_to :user 
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :time, presence: true, :numericality => true
  
  default_scope order: 'tasks.created_at DESC'
  
end
