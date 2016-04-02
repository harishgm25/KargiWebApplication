module Api
  module V1
    class FindconnectionsController < ApplicationController

      #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
      before_filter :restrict_access
      respond_to :json


    def addfriendrequest
      puts "--------------------------"
      puts params[:findconnection][:friend]
      puts params[:findconnection][:user_id]
       puts "--------------------------"
      @findconnection = Findconnection.new
      @findconnection.friend =  params[:findconnection][:friend].as_json
      @findconnection.user_id = params[:findconnection][:user_id]
      @findconnection.status = "waiting"
      @findconnection.save!

    end 
 


    def findconnection_params
      params.require(:findconnection).permit(:friend, :status)
    end


    def as_json(*args)
    res = super

    # convert BSON::ObjectId to string
    res["_id"] = res["_id"].to_s

    # or you also can change attribute name from _id to id
    # res["id"] = res.delete("_id").to_s
    puts "--------------------------------------"
    puts res
    res
  end
    private
    def restrict_access
      #api_key  = User.where(:authentication_token => params[:access_token]).first
      #head :unauthorized unless api_key
      authenticate_or_request_with_http_token do |token, options|
        puts token
         User.where(authentication_token: token).exists?
         #else
          #return render :json => {:success => false, :errors => ["Update Failed"]}
         #end

        end
      end
   
    end
  end
end

