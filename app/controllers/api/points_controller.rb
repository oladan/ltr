module Api
  class PointsController < BaseController
    before_filter :load_point, only: [:destroy, :show, :update]

    # GET /api/points
    def index
      @points = PointsQuery.new(
        current_user, 
        params[:address_filt], 
        params[:city_filt], 
        params[:country_filt], 
        params[:price_from], 
        params[:price_to]
      ).query_with_order
    end

    # POST /api/points
    def create
      @point = current_user.points.build(point_params)
      if @point.save
        render status: :created
      else
        render json: {errors: @point.errors.full_messages}, status: :unprocessable_entity
      end
    end

    # DELETE /api/points/:id
    def destroy
      @point.destroy
      head :no_content
    end

    # GET /api/points/:id
    def show
    end

    # PATCH /api/points/:id
    def update
      @point.update! point_params
    end

    private

      def point_params
        params.require(:point).permit(:title, :price, :place)
      end

      def load_point
        @point = current_user.points.find(params[:id])
      end

  end
end
