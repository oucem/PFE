class Group
  include Mongoid::Document
     has_many :users
     belongs_to :company

  field :name, type: String
  field :member_nbr, type: Integer
  #validates_associated :users, :company
  validates_presence_of :company_id

end
