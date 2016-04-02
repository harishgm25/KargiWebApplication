module Api
  module V1
    class ProfilesController < ApplicationController

      #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
      before_filter :restrict_access
      respond_to :json
 


 
# GET /profiles/1/edit
  def edit

  end

  def showconnectionprofile
      @jsonholder = Array.new
      @profiles = Profile.without(:profileImg_fingerprint,:profileImg_content_type,:profileImg_file_size).all
      @profiles.each do |profile|
        @json = Array.new
        @profilesuser= User.find(profile.user_id)
       
        @json << profile << {:imagepath => profile.profileImg.url.to_s}
        @json << @profilesuser
        
        @jsonholder<<@json
        puts "-----------------------------------------"
      end
      puts @jsonholder.as_json
      return render :json => {:profile => @jsonholder }
  end

  def getprofile
     @profile = Profile.where(:user_id =>(params[:profile][:id])).first
     return render :json => {:success => true, :profile => @profile , :profileImg => @profile.profileImg.url }
  end

  def updateprofile
       @profile = Profile.where(:user_id =>(params[:profile][:id])).first
       puts profile_params
       @profile.lastname = params[:profile][:lastname]
       @profile.firstname = params[:profile][:firstname]
       @profile.nameoffirm = params[:profile][:nameoffirm]
       @profile.estyear = params[:profile][:estyear]
       @profile.website = params[:profile][:website]
       @profile.pan = params[:profile][:pan]
       @profile.tanvat = params[:profile][:tanvat]
       @profile.bankacc = params[:profile][:bankacc]
       @profile.billingaddress = params[:profile][:billingaddress]
       @profile.deliveryaddress = params[:profile][:deliveryaddress]
       @profile.profileImg = params[:profile][:profileImg]  

       
      
         
      if @profile.save!
          
          render :json => {:success => true }
      else
       
         # render :json =>{:succes => false}
        return render :json => {:success => false, :errors => ["Update Failed"]}

      end
  end

  def updatemobile
       @profile = Profile.where(:user_id =>(params[:profile][:id])).first
       puts profile_params
       @user = User.find(@profile.user_id)
       @user.mobile = params[:profile][:mobile]
       if @user.save!
          
          render :json => {:success => true, :mobile => @user.mobile }
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
      params.require(:profile).permit(:firstname,:lastname,:tanvat,:nameoffirm,:estyear,:website,:pan,:bankacc,:billingaddress,:deliveryaddress,:id,:profileImg,:mobile)
    end
   
    end
  end
end

module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json
    end

    def as_json(*args)
      to_s.as_json
    end
  end
end