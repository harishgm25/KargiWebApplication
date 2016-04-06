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

    def getfriendrequeststatus
      @jsonmyrequestarray = Array.new
      userid = params[:findconnection][:user_id]
      puts params[:findconnection][:user_id]
      @findconnection = Findconnection.all
      @findconnection.each do |row|
        # getting my friend request
       if(row.user_id.to_s==params[:findconnection][:user_id])
          @jsonmyrequest = Array.new
          @jsonmyrequest<<row     #getting status
          @profile = Profile.without(:profileImg_fingerprint,:profileImg_content_type,:profileImg_file_size).where(:user_id=>row.friend).first # getting profile of my friend
          @jsonmyrequest << @profile << {:imagepath => @profile.profileImg.url.to_s}
          @jsonmyrequest << User.find(@profile.user_id) 
          puts "***************************************************"
          puts @jsonmyrequest.as_json
          @jsonmyrequestarray<<@jsonmyrequest
        end
      end
      return render :json => {:success => true,:myfriendrequest => @jsonmyrequestarray }
    end

    def getotherfriendrequeststatus
      @jsonmyrequestarray = Array.new
      userid = params[:findconnection][:user_id]
      puts params[:findconnection][:user_id]
      @findconnection = Findconnection.all
      @findconnection.each do |row|
        # getting other friend request
       if(row.friend.to_s==params[:findconnection][:user_id])
          @jsonmyrequest = Array.new
          @jsonmyrequest<<row     #getting status
          @profile = Profile.without(:profileImg_fingerprint,:profileImg_content_type,:profileImg_file_size).where(:user_id=>row.user_id).first # getting profile of my friend
          @jsonmyrequest << @profile << {:imagepath => @profile.profileImg.url.to_s}
          @jsonmyrequest << User.find(@profile.user_id) 
          
          puts @jsonmyrequest.as_json
          @jsonmyrequestarray<<@jsonmyrequest
        end
      end
      return render :json => {:success => true,:otherfriendrequest => @jsonmyrequestarray }
    end

     def approveotherfriendrequeststatus
     
     # approving friend---------------------------
      friendid = params[:findconnection][:friend]
      userid = params[:findconnection][:user_id]
      puts params[:findconnection][:friend]
      puts userid
      @findconnection = Findconnection.where(:friend => userid, :user_id =>friendid)
      @findconnection.each do |row|
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++"
        # getting approve friend request
        row.status = "approved"
        row.update_attributes()    
      end
      return render :json => {:success => true }
    end
      
     def removeotherfriendrequeststatus
     # remove mutual request friend---------------------------
      friendid = params[:findconnection][:friend]
      userid = params[:findconnection][:user_id]
      puts params[:findconnection][:friend]
      puts userid
      @findconnection = Findconnection.where(:friend => userid, :user_id =>friendid)
      @findconnection.each do |row|
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++"
        row.destroy
      end
      @findconnection = Findconnection.where(:friend => friendid, :user_id =>userid)
      @findconnection.each do |row|
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++"
        row.destroy 
      end

      return render :json => {:success => true }
    end


    def findconnection_params
      params.require(:findconnection).permit(:friend,:status,:user_id)
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

