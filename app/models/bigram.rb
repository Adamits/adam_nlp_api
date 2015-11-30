class Bigram < ActiveRecord::Base

  belongs_to :document
  has_many :terms
end
