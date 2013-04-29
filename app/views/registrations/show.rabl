object @user
attributes :id, :role, :company_id, :group_id, :email, :created_at, :is_ad, :first_name, :last_name, :resp, :start_date, :school_level, :picture, :home_phone, :cell_phone,:adress, :remember_created_at
node(:full_name) {|user|
  [user.first_name, user.last_name].join(" ")}