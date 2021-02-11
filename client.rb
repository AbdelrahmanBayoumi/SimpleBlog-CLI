load 'user.rb'
load 'post.rb'

if ARGV[0] == "--help" then
    puts "
    For Users
    Create new account          --signup <email> <password> <password_confirmation> <first_name> <last_name> <phone> <gender> <address>
    Login into account          --signin <email> <password>
    Get current user data       --userdata <current_user_id>
    Get all users data          --usersdata
    Update current user data    --updateuser <current_user_id> <email> <first_name> <last_name> <phone> <gender> <address>
    For Posts   
    Create new post             --creaetpost <title> <body, inside ""> <tags, separated by ,>
    Update post data            --updatepost <post_id> <title> <body, inside ""> <tags, separated by ,>
    Get post data               --postdata <post_id>
    Get all posts data          --postsdata
    For Comments
    Create comment for posts    --addcomment <post_id> <body, inside "">
    Update comment data         --updatecomment <comment_id> <body, inside "">
    For Followers
    Show followers              --showfollowers <current_user_id>
    Show followings             --showfollowings <current_user_id>
    Follow user                 --followuser <user_id>
    Unfollow user               --unfollowuser <user_id> 
    "
###############################################################################
###############################################################################
# User
elsif ARGV[0] == "--signup" then
    # ruby client.rb --signup test2@test.com Test@1234 Test@1234  ali saad 01232134121
    user = User.new(email: ARGV[1], password: ARGV[2], password_confirmation: ARGV[3],
    first_name: ARGV[4], last_name: ARGV[5], phone: ARGV[6], gender: ARGV[7], address: ARGV[8])
    res = user.sign_up(user)
    puts res
elsif ARGV[0] == "--signin" then
    # ruby client.rb --signin test2@test.com Test@1234
    user = User.new(email: ARGV[1], password: ARGV[2])
    res = user.sign_in
    puts res
elsif ARGV[0] == "--userdata" then
    # ruby client.rb --userdata 6
    user = User.new
    res = user.user_data(ARGV[1])
    puts res
elsif ARGV[0] == "--usersdata" then
    # ruby client.rb --usersdata
    user = User.new
    res = user.users_data
    puts res
elsif ARGV[0] == "--updateuser" then
    # ruby client.rb --updateuser 6 test2@test.com omar saad 01232134121 male
    user = User.new(email: ARGV[2],first_name: ARGV[3], last_name: ARGV[4],
    phone: ARGV[5], gender: ARGV[6], address: ARGV[7])
    res = user.update_user(user, ARGV[1])
    puts res
###############################################################################
###############################################################################
# Post
elsif ARGV[0] == "--createpost" then
    # ruby client.rb --createpost test my_name_is_omar test,test2
    post = Post.new(title: ARGV[1], body: ARGV[2], all_tags: ARGV[3])
    res = post.creaet_post(post)
    puts res
elsif ARGV[0] == "--updatepost" then
    # ruby client.rb --updatepost 2 test2 my_name_is_omar we,orange
    post = Post.new(title: ARGV[2], body: ARGV[3], all_tags: ARGV[4])
    res = post.update_post(post, ARGV[1])
    puts res
elsif ARGV[0] == "--postdata" then
    # ruby client.rb --postdata 2
    post = Post.new
    res = post.post_data(ARGV[1])
    puts res
elsif ARGV[0] == "--postsdata" then
    # ruby client.rb --postsdata
    post = Post.new
    res = post.posts_data
    puts res
###############################################################################
###############################################################################
# Comment
elsif ARGV[0] == "--addcomment" then
    # ruby client.rb --addcomment 2 Just_Test_Comment
    post = Post.new
    res = post.add_comment(ARGV[2], ARGV[1])
    puts res
elsif ARGV[0] == "--updatecomment" then
    # ruby client.rb --updatecomment 2 Just_Test2_Comment
    post = Post.new
    res = post.add_comment(ARGV[2], ARGV[1])
    puts res
###############################################################################
###############################################################################
# Followers
elsif ARGV[0] == "--showfollowers" then
    # ruby client.rb --showfollowers 2
    user = User.new
    res = user.show_followers(ARGV[1])
    puts res
elsif ARGV[0] == "--showfollowings" then
    # ruby client.rb --showfollowings 2
    user = User.new
    res = user.show_followings(ARGV[1])
    puts res
elsif ARGV[0] == "--followuser" then
    # ruby client.rb --showfollowings 1
    user = User.new
    res = user.follow_user(ARGV[1])
    puts res
elsif ARGV[0] == "--unfollowuser" then
    # ruby client.rb --showfollowings 1
    user = User.new
    res = user.unfollow_user(ARGV[1])
    puts res
else
    puts "Pleasr run --help"
end