module Api
  class PointsController < BaseController
    before_filter :load_point, only: [:destroy, :show, :update, :delete_picture]

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
        if params[:point][:pictures]
          params[:point][:pictures].each { |key, picture|
            @point.pictures.create(pic: picture)
          }
        end
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
      if params[:point][:pictures]
        params[:point][:pictures].each { |key, picture|
          @point.pictures.create(pic: picture)
        }
      end
    end

    def delete_picture
      if params[:point_photo_id] && params[:id]
        x = @point.pictures.find params[:point_photo_id]
        x.delete
      end
    end

    def points_types
      @types = Type.all.select(:id, :title)
      render json: @types
    end

    private

      def point_params
        params.require(:point).permit(:title, :price, :place, :avatar, :pictures, :point_photo_id, :phone, :type_id)
      end

      def load_point
        @point = current_user.points.find(params[:id])
      end

  end
end
