class VideoBlogsController < ApplicationController
  include SessionsHelper
  before_action :set_video_blog, only: [:show, :edit, :update, :destroy, :deal_reply]
  before_action :ensure_logged_in
  # GET /video_blogs
  # GET /video_blogs.json
  def index
    @video_blogs = VideoBlog.all
    @tag_id = -1
    @tags = Tag.all
  end

  # GET /video_blogs/1
  # GET /video_blogs/1.json
  def show
    @video_blog = VideoBlog.find(params[:id])
    @video_blog.click_count += 1
    @video_blog.save
    @feed_items = @video_blog.feed.paginate(page: params[:page])
  end

  # GET /video_blogs/new
  def new
    @video_blog = VideoBlog.new
    @all_tags = Tag.get_all_tags
  end

  # GET /video_blogs/1/edit
  def edit
    @all_tags = Tag.get_all_tags
  end

  # POST /video_blogs
  # POST /video_blogs.json
  def create
    @all_tags = Tag.get_all_tags
    @video_blog = current_user.video_blogs.new(video_blog_params)
    @video_blog.response_count = 0
    @video_blog.click_count = 0
    @video_blog.accessment = 0
    unless request.get?
      file = params[:video_blog][:file_path]
      unless file
        flash.now[:danger] = "文件不能为空"
        render '/video_blogs/new'
        return
      end 
      if file.size > 40000000
        flash.now[:danger] = "文件不能大于40MB"
        render '/video_blogs/new'
        return
      end
      unless ["mp4"].include?(file.original_filename.chomp.split(".")[-1])
        flash.now[:danger] = "文件格式只能为"+["mp4"].to_s
        render '/video_blogs/new'
        return
      end
      filename = uploadfile(params[:video_blog][:file_path])
      @video_blog.file_path = filename
    end
    unless @video_blog.save
      render '/video_blogs/new'
    else
      redirect_to "/video_blogs/#{@video_blog.id}"
    end
  end

  def uploadfile(file)
    @filename = file.original_filename
    @file_type = @filename.chomp.split(".")[-1]
    #设置目录路径，如果目录不存在，生成新目录
    FileUtils.mkdir("#{Rails.root}/app/assets/videos") unless File.exist?("#{Rails.root}/app/assets/videos")
    #写入文件
    ##wb 表示通过二进制方式写，可以保证文件不损坏
    File.open("#{Rails.root}/app/assets/videos/#{@filename}", "wb") do |f|
      f.write(file.read)
    end
    return @filename
  end

  # PATCH/PUT /video_blogs/1
  # PATCH/PUT /video_blogs/1.json
  def update
    respond_to do |format|
      if @video_blog.update(video_blog_params)
        format.html { redirect_to @video_blog, notice: '更新成功' }
        format.json { render :show, status: :ok, location: @video_blog }
      else
        format.html { render :edit }
        format.json { render json: @video_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_blogs/1
  # DELETE /video_blogs/1.json
  def destroy
    ids = @video_blog.video_replys.collect{|x| x.reply.id} #some BUG with foreign key:(--zh
    @video_blog.video_replys.each{|x| x.destroy}
    ids.each{|id| Reply.find(id).destroy}
    @video_blog.destroy
    respond_to do |format|
      format.html { redirect_to user_videos_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end
  
  # POST /video_blogs/1/reply
  def deal_reply
    #set_video_blog
    @video_blog.response_count += 1
    #@video_blog.save
    @reply = Reply.create(send_user_id: current_user.id,receive_user_id: params[:receiver_id], content: params[:content]) 
    @video_reply = @video_blog.video_replys.new
    @video_reply.reply_id = @reply.id
    if params[:content].length<2 or params[:content].length>50
      flash[:danger] = "回复长度必须在2-50字"
    end
    if @video_blog.save
      flash[:success] = "发表成功"
    else
      flash[:danger] = "发表失败"
    end
    redirect_to "/video_blogs/#{@video_blog.id}"
  end
  
  #GET '/video_blogs/tags/:id'
  def show_tag
    @video_blogs = VideoBlog.where("tag_id = ?", params[:id])
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
    def set_video_blog
      @video_blog = VideoBlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_blog_params
      params.require(:video_blog).permit(:title, :tag_id, :content)
    end
end
