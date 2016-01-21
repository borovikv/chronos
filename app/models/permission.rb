class Permission < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  validates_uniqueness_of :board_id, scope: :user_id

  validates_inclusion_of :permission, in: PermissionController.helpers.permission_values, message: '%{value} is not a valid'


end
