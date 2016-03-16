module Api
  module V1
    class ProductsController < ApplicationController
      #http_basic_authenticate_with name: "admin", password: "secret"
      protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
     
      before_filter :restrict_access
      respond_to :json
 
      def index
        respond_with Product.all
      end

      def show
          respond_with Product.find(params[:id])
      end

      def create
            @key ="12111212"
            @product = Product.new
            @product.name = params[:product][:name]
            @product.description = params[:product][:description]
            respond_to do |format|
             if @product.save
                format.json { render json: @product, success: :true, location: @product}
            else
                
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
      end
           
      end

      def update
          respond_with Product.update(params[:id],params[:product])
      end

      def destroy
           respond_with Product.destroy(params[:id])
      end

      private
       def restrict_access
       
        #api_key  = User.where(:authentication_token => params[:access_token]).first
        #head :unauthorized unless api_key
       authenticate_or_request_with_http_token do |token, options|
       puts token
        User.where(authentication_token: token).exists?

        end
        end
#
    end
  end
end

