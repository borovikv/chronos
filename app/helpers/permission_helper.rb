module PermissionHelper
  def permission_types
    [['read', 1], ['edit', 2], ['card only', 3]]
  end

  def permission_values
    permission_types.map {|key, value| value}
  end
end
