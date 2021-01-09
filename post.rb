require 'httparty'
require 'json'

class Post
    def initialize(title: nil, body: nil, all_tags: nil)
        @@title = title
        @@body = body
        @@all_tags = all_tags
    end

    def convert_json
        {
            "title" => @@title,
            "body" => @@body,
            "all_tags" => @@all_tags
        }
    end

    def creaet_post(post)
        data = {"post": post.convert_json}.to_json
        token = JSON.parse(File.read("token.txt"))
        token['Content-Type'] = 'application/json'
        puts data, token
        response = HTTParty.post('https://secure-reef-98071.herokuapp.com/api/v1/posts/', body: data,
            headers: token)
        return response.body
    end

    def update_post(post, id)
        data = {"post": post.convert_json}.to_json
        token = JSON.parse(File.read("token.txt"))
        token['Content-Type'] = 'application/json'
        response = HTTParty.put("https://secure-reef-98071.herokuapp.com/api/v1/posts/#{id}", body: data,
            headers: token)
        return response.body
    end

    def post_data(id)
        token = JSON.parse(File.read("token.txt"))
        response = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/posts/#{id}",
            headers: token)
        return response.body
    end

    def posts_data
        token = JSON.parse(File.read("token.txt"))
        response = HTTParty.get("https://secure-reef-98071.herokuapp.com/api/v1/posts/",
            headers: token)
        return response.body
    end

    def add_comment(body, id)
        data = {"comment": {"body": body}}.to_json
        token = JSON.parse(File.read("token.txt"))
        token['Content-Type'] = 'application/json'
        response = HTTParty.post("https://secure-reef-98071.herokuapp.com/api/v1/posts/#{id}/comments", body: data,
            headers: token)
        return response.body
    end

    def update_comment(body, id)
        data = {"comment": {"body": body}}.to_json
        token = JSON.parse(File.read("token.txt"))
        token['Content-Type'] = 'application/json'
        response = HTTParty.put("https://secure-reef-98071.herokuapp.com/api/v1/comments/#{id}", body: data,
            headers: token)
        return response.body
    end
end