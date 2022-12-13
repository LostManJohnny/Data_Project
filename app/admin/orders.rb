ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :complete_date, :status_id, :shipping_cost, :shipping_address
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :complete_date, :status_id, :shipping_cost, :shipping_address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
