module Api
  module V1
    class ProfilesController < ApplicationController

      #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
      before_filter :restrict_access
      respond_to :json
 


# GET /profiles/1/edit
  def edit

  end

  def getprofile
     @profile = Profile.where(:user_id =>(params[:profile][:id])).first
     
      return render :json => {:success => true, :profile => @profile }

  end

  def updateprofile
        puts "-----------------------------------------------"
         
         @profile = Profile.where(:user_id =>(params[:profile][:id])).first
         
         puts @profile.to_json
      if @profile.update(profile_params)
          render :json => {:success => true }
      else
       
         # render :json =>{:succes => false}
        return render :json => {:success => false, :errors => ["Update Failed"]}

      end
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
    def profile_params
      params.require(:profile).permit(:firstname, :lastname, :shopname, :address, :tanvat, :registerno, :shopestablishment, :tradelicense, :manufacturinglicense)
    end
   
    end
  end
end

