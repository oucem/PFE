class Company
  include Mongoid::Document
   has_many :groups
   has_many :users
   #has_one :admin
   #has_many :users, :through => :group
   
  field :name, type: String
  field :employee_nbr, type: Integer
  #field :location,         :type => String, :default => "" 
  #field :phone,              :type => String, :default => ""
  #field :website,              :type => String, :default => ""
  
  def users
     self.groups.where(type: 'user')
  end
end
