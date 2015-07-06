class PointsQuery

  def initialize(user)
    @user = user
  end

  def query
    scope = @user.points
    scope
  end

  def query_with_order
    query.order(user_id: :desc)
  end
end
