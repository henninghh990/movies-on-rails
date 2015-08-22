class List < ActiveRecord::Base
	has_many :movie_lists
	has_many :movies, :through => :movie_lists
	belongs_to :user

	validates_presence_of :name
	validates_length_of :name, :maximum => 30
end
