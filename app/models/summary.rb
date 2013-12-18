class Summary < ActiveRecord::Base
  # This only does a many to many associations between transaction and event, but I will keep the tables name...
  belongs_to :transaction
  belongs_to :event
  # attr_accessible :title, :body
end
