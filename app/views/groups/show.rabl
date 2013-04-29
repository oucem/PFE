object @group 
attributes :id, :name, :description, :admin
child :users do
extends 'users/show'
end