object @company
attributes :name, :employee_nbr, :id

child :groups do
extends 'groups/list'
end

child :users do
extends 'users/show'
end