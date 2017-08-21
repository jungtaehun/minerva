require 'open-uri'
require 'json'
require "net/https"
require "uri"
require 'faraday'



class SessionsController < ApplicationController
  before_action :authenticate_user!, except: [:auth]

  def new
  end

  def create
    user = Student.find_by_email(params[:email])
    if user && User.find_by_password(params[:password])
      session[:user_id] = user.id
      redirect_to "/"
    else
      render "new"
    end
  end

  def login
  end

  def auth
    username = "#{params[:id]}"
    password = "#{params[:password]}"
    res = Faraday.get do |req|
      req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/login.jsp'
    end
    jsessionid = res.headers.to_hash.to_s.split("JSESSIONID=")[1].split(";")[0]

    res = Faraday.post do |req|
      req.url 'https://tsso.koreatech.ac.kr/svc/tk/Login.do'
      req.headers = {'Host' => 'tsso.koreatech.ac.kr',
                     'Referer' => 'http://app2.koreatech.ac.kr/mobileApp/sso/login.jsp',
                     'Content-Type' => 'application/x-www-form-urlencoded',
                     'Cookie' => 'JSESSIONID=' + jsessionid.split(".www")[0] + '; returnUrl=L2ZpbGVib3gvZmlsZWJveEZyb250LmRvP2NtZD1tYWlu; _ga=GA1.3.187598766.1499980133; _gid=GA1.3.79499603.1499980133',
                     'X-Requested-With' => 'kr.ac.koreatech.life'}
      req.body = {:user_id => "#{username}", :user_password => "#{password}", :RelayState => '%2FmobileApp%2Fsso%2Flogin_post_proc2.jsp', :id => 'APP2', :targetId => 'APP2'}
    end

    result = res.headers.to_hash.to_s
    location = URI(result.split('location"=>"')[1].split('"')[0])

    res = Faraday.get do |req|
      req.url location
      req.headers['Host'] = 'app2.koreatech.ac.kr'
      req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
      req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
      req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
    end

    jsessionid = res.headers.to_hash.to_s.split("JSESSIONID=")[1].split(";")[0]

    res = Faraday.get do |req|
      req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/login_post_proc2.jsp'
      req.headers['Host'] = 'app2.koreatech.ac.kr'
      req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
      req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
      req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
    end


    res = Faraday.get do |req|
      req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/view2.jsp?login=Y'
      req.headers['Host'] = 'app2.koreatech.ac.kr'
      req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
      req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
      req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
    end

    if res.body.include? "Logined : Y"
        hakbun = res.body.split('sEmpNo : ')[1].split(' <br/>')[0]
        # NameK1 = res.body.split('sUserNmK : ')[1].split(' <br/>')[0].force_encoding('UTF-8')
      respond_to do |format|
        format.html {redirect_to new_user_registration_path, notice: [username, hakbun]}
      end
    else
      respond_to do |format|
        format.html {redirect_back fallback_location: root_path, notice: 'failed'}
      end
    end
  end

  def test

    @ttt = params[:id]
    @aaa = params[:hakbun]
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end
