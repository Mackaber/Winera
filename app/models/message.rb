class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :link, :seen
end
