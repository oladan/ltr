class PointsQuery

  def initialize(user, address_filt, city_filt, country_filt, price_from, price_to)
    @user = user
    @price_from = price_from
    @price_to = price_to
    @country_filt = country_filt
    @city_filt = city_filt
    @address_filt = address_filt
  end

  def query
    scope = @user.points
    scope = scope.where("points.price >= ?", @price_from) if @price_from
    scope = scope.where("points.price <= ?", @price_to) if @price_to
    scope = scope.where("lower(points.city) LIKE ?", "%#{@city_filt.downcase}%") if @city_filt
    scope = scope.where("lower(points.country) LIKE ?", "%#{@country_filt.downcase}%") if @country_filt
    scope = scope.where("lower(points.street) LIKE ?", "%#{@address_filt.downcase}%") if @address_filt
    scope
  end

  def query_with_order
    query.order(updated_at: :desc)
  end
end
