class Group
  include Mongoid::Document
     has_many :users
     belongs_to :company

  field :name, type: String
  field :member_nbr, type: Integer #, :default => users.count
  field :description, type: String 
  #validates_associated :users, :company
  validates_presence_of :company_id
  validates_uniqueness_of :name

end
