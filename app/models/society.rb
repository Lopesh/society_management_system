class Society < ApplicationRecord
  def users
    User.all
  end

  def wings
    Wing.all
  end
end
