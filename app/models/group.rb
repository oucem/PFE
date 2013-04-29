class Group
  include Mongoid::Document
  has_many :users
  belongs_to :company

  field :name, type: String
  field :member_nbr, type: Integer , :default => 0
  field :description, type: String
  field :admin ,type: String, :default =>""
  #validates_associated :users, :company
  validates_presence_of :company_id
  validates_uniqueness_of :name, :scope => :company_id
end
