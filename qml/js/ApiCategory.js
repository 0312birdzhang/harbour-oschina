.pragma library

//-------------------认证接口-------------------------------//
//OpenAPI 授权登录页面
var oauth2_authorize ="/action/oauth2/authorize";

//authorization_code 方式获取 AccessToken
var oauth2_token = "/action/openapi/token";

//-------------------个人信息-------------------------------//
//获取当前登录用户的账户信息
var openapi_user = "/action/openapi/user";

//用户详情
var user_information = "/action/openapi/user_information";

//个人主页详情
var my_information = "/action/openapi/my_information";

//头像更新
var portrait_update = "/action/openapi/portrait_update";

//获取好友列表
var friends_list = "/action/openapi/friends_list";

//获取动态列表
var active_list = "/action/openapi/active_list";

//更新好友关系（加关注、取消关注）
var update_user_relation = "/action/openapi/update_user_relation";

//-------------------新闻-------------------------------//
//获取新闻列表
var news_list = "/action/openapi/news_list"

//获取新闻详情
var news_detail = "/action/openapi/news_detail"

//-------------------帖子-------------------------------//
//获取讨论区的帖子列表(对应android的 问答 分享 综合 职业 站务)
var post_list = "/action/openapi/post_list";

//发布帖子
var post_pub = "/action/openapi/post_pub";

//获取讨论区的帖子详情
var post_detail = "/action/openapi/post_detail";

//-------------------动弹-------------------------------//
//获取动弹列表 （最新动弹列表 我的动弹）
var tweet_list = "/action/openapi/tweet_list";

//获取动弹列表
var tweet_detail = "/action/openapi/tweet_detail";

//发布动弹
var tweet_pub = "/action/openapi/tweet_pub";

//删除动弹
var tweet_delete = "/action/openapi/tweet_delete";

//-------------------博客-------------------------------//
//发布博客
var blog_pub = "/action/openapi/blog_pub";

//获取博客列表
var blog_list = "/action/openapi/blog_list";

//获取博客推荐列表
var blog_recommend_list = "/action/openapi/blog_recommend_list";

//获取博客详情
var blog_detail = "/action/openapi/blog_detail";

//获取用户博客列表
var user_blog_list = "/action/openapi/user_blog_list";

//获取用户博客列表
var blog_catalog_list = "/action/openapi/user_blog_list"

//-------------------评论-------------------------------//
//获取博客评论列表
var blog_comment_list = "/action/openapi/blog_comment_list";

//发表博客评论
var blog_comment_pub = "/action/openapi/blog_comment_pub";

//回复博客评论
var blog_comment_reply = "/action/openapi/blog_comment_reply";

//删除用户博客
var user_blog_delete = "/action/openapi/user_blog_delete";

//获取评论列表
var omment_list = "/action/openapi/comment_list";

//发表评论
var comment_pub = "/action/openapi/comment_pub";

//回复评论
var comment_reply = "/action/openapi/comment_reply";

//删除评论
var comment_delete = "/action/openapi/comment_delete";

//-------------------收藏-------------------------------//
//获取收藏列表
var favorite_list = "/action/openapi/favorite_list";

//添加收藏
var favorite_add = "/action/openapi/favorite_add";

//取消收藏
var favorite_remove = "/action/openapi/favorite_remove";


//-------------------软件-------------------------------//
//获取软件详情
var project_detail = "/action/openapi/project_detail";

//获取软件分类列表(只有2级)
var project_catalog_list = "/action/openapi/project_catalog_list";

//软件分类下的的软件列表
var project_list = "/action/openapi/project_list";

//Tag下的软件列表
var project_tag_list = "/action/openapi/project_tag_list";

//-------------------私信-------------------------------//
//获取私信列表
var message_list = "/action/openapi/message_list";

//删除私信
var message_delete = "/action/openapi/message_delete"

//-------------------搜索-------------------------------//
//获取搜索列表
var search_list = "/action/openapi/search_list";

//-------------------通知-------------------------------//
//获取用户通知
var user_notice = "/action/openapi/user_notice";

//清除用户通知
var clear_notice = "/action/openapi/clear_notice";
