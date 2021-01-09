class TextBlogsController < ApplicationController
  include SessionsHelper
  before_action :set_text_blog, only: [:show, :edit, :update, :destroy, :deal_reply]
  before_action :ensure_logged_in
  # GET /text_blogs
  # GET /text_blogs.json
  def index
    @text_blogs = TextBlog.all.paginate(page: params[:page],per_page: 12)
    @tag_id = -1
    @tags = Tag.all
  end

  # GET /text_blogs/1
  # GET /text_blogs/1.json
  def show
    @text_blog = TextBlog.find(params[:id])
    @text_blog.click_count += 1
    @text_blog.save
    @feed_items = @text_blog.feed.paginate(page: params[:page],per_page: 12)
    @user = User.find(params[:id])
    @cuser = current_user
  end

  # GET /text_blogs/new
  def new
    @text_blog = TextBlog.new
    @all_tags = Tag.get_all_tags
  end

  # GET /text_blogs/1/edit
  def edit
    @all_tags = Tag.get_all_tags
  end

  # POST /text_blogs
  # POST /text_blogs.json
  def create
    @text_blog = current_user.text_blogs.new(text_blog_params)
    @all_tags = Tag.get_all_tags
    @text_blog.response_count = 0
    @text_blog.click_count = 0
    @text_blog.accessment = 0
    unless @text_blog.save
      render '/text_blogs/new'
    else
      redirect_to "/text_blogs/#{@text_blog.id}"
    end
    # respond_to do |format|
    #   if @text_blog.save
    #     format.html { redirect_to @text_blog, notice: 'Text blog was successfully created.' }
    #     format.json { render :show, status: :created, location: @text_blog }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @text_blog.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /text_blogs/1
  # PATCH/PUT /text_blogs/1.json
  def update
    respond_to do |format|
      if @text_blog.update(text_blog_params)
        format.html { redirect_to @text_blog, notice: '更新成功' }
        format.json { render :show, status: :ok, location: @text_blog }
      else
        format.html { render :edit }
        format.json { render json: @text_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_blogs/1
  # DELETE /text_blogs/1.json
  def destroy
    ids = @text_blog.text_replys.collect{|x| x.reply.id}
    @text_blog.text_replys.each{|x| x.destroy}
    ids.each{|id| Reply.find(id).destroy}
    @text_blog.destroy
    respond_to do |format|
      format.html { redirect_to user_texts_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  def deal_reply
    #set_text_blog
    @text_blog.response_count += 1
    #@text_blog.save
    @reply = Reply.create(send_user_id: current_user.id,receive_user_id: params[:receiver_id], content: params[:content]) 
    @text_reply = @text_blog.text_replys.new
    @text_reply.reply_id = @reply.id
    if params[:content].length<2 or params[:content].length>50
      flash[:danger] = "回复长度必须在2-50字"
    end
    if @text_blog.save
      flash[:success] = "发表成功"
    else
      flash[:danger] = "发表失败"
    end
    redirect_to "/text_blogs/#{@text_blog.id}"
  end

  def show_tag
    @text_blogs = TextBlog.where("tag_id = ?", params[:id]).paginate(page: params[:page], per_page: 12)
    @tags = Tag.all
    @tag_id = params[:id].to_i
    @tag_name = Tag.find(params[:id]).name
  end
  
  private
    def ensure_logged_in
      unless logged_in?
        store_forwarding_url
        flash[:warning] = "请先登录！"
        redirect_to login_url
      end
    end  
    # Use callbacks to share common setup or constraints between actions.
    def set_text_blog
      @text_blog = TextBlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def text_blog_params
      params.require(:text_blog).permit(:title, :tag_id, :content)
    end
end
