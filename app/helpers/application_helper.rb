module ApplicationHelper
  def update_nbr_user(id,option)
    puts "#######test#########"
    @group = Group.find(id)
    if option=="inc"
      x = @group.member_nbr + 1
      @group.update_attribute(:member_nbr , x)
    else if option=="dec"
        x= @group.member_nbr - 1
        @group.update_attribute(:member_nbr , x)
      end
    end
    @group.update_attributes(params[:group])
    puts "#####result########"
  end
end
