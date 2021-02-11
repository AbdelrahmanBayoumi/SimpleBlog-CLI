require 'httparty'
require 'json'

class User
    @access_token = nil
    @client = nil
    @uid = nil
    def initialize(email: nil, phone: nil, password: nil, password_confirmation: nil, first_name: nil, last_name: nil, gender: nil, address: nil)
        @email = email
        @phone = phone
        @password = password
        @password_confirmation = password_confirmation
        @first_name = first_name
        @last_name = last_name
        @gender = gender
        @address = address
    end

    def convert_json
        {"email" => @email,
        "phone" => @phone,
        "password" => @password,
        "password_confirmation" => @password_confirmation,
        "first_name" => @first_name,
        "last_name" => @last_name,
        "gender" => @gender,
        "address" => @address}
    end
    
    def sign_up(user)
        data = {"user": user.convert_json}.to_json
        response = HTTParty.post('https://secure-reef-98071.herokuapp.com/api/v1/users/sign_up',
            body: data, headers: {'Content-Type' => 'application/json'})
        @access_token = response.headers["access-token"]
        @client = response.headers["client"]
        @uid = response.headers["uid"]
        token = {'access-token' => @access_token, 'client' => @client, 'uid' => @uid}.to_json
        File.write("token.txt", token)
        return response.body
    end

    def sign_in
        data = {"user": {"email": @email, "password": @password}}.to_json
        response = HTTParty.post('https://secure-reef-98071.herokuapp.com/api/v1/users/sign_in',
            body: data, headers: {'Content-Type' => 'application/json'})
        @access_token = response.headers["access-token"]
        @client = response.headers["client"]
        @uid = response.headers["uid"]
        token = {'access-token' => @access_token, 'client' => @client, 'uid' => @uid}.to_json
        File.write("token.txt", token)
        return response.body
    end

    def user_data(id)
        token = JSON.parse(File.read("token.txt"))
        response = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}",
            headers: token)
        return response.body
    end

    def users_data
        token = JSON.parse(File.read("token.txt"))
        response = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/users/",
            headers: token)
        return response.body
    end

    def update_user(user, id)
        data = {"user": user.convert_json}.to_json
        token = JSON.parse(File.read("token.txt"))
        token['Content-Type'] = 'application/json'
        res = HTTParty.put("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}", body: data,
            headers: token)
        return res
    end
    
    def show_followers(id)
        token = JSON.parse(File.read("token.txt"))
        res = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}/followers",
            headers: token)
        return res
    end

    def show_followings(id)
        token = JSON.parse(File.read("token.txt"))
        res = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}/followings",
            headers: token)
        return res
    end

    def follow_user(id)
        token = JSON.parse(File.read("token.txt"))
        res = HTTParty.post("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}/follow",
            headers: token)
        return res
    end

    def unfollow_user(id)
        token = JSON.parse(File.read("token.txt"))
        res = HTTParty.post("https://secure-reef-98071.herokuapp.com/api/v1/users/#{id}/unfollow",
            headers: token)
        return res
    end
end
