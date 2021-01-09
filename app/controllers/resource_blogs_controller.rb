class ResourceBlogsController < ApplicationController
  include SessionsHelper
  #确保已经登录
  before_action :ensure_logged_in
  #将页面设置为当前用户的参数
  before_action :set_resource_blog, only: [:show, :edit, :update, :destroy, :deal_reply]
  # GET /resource_blogs
  # GET /resource_blogs.json
  def index
    @resource_blogs = ResourceBlog.all
    #加入已有的各版块信息
    @tag_id = -1
    @tags = Tag.all
  end

  # GET /resource_blogs/1
  # GET /resource_blogs/1.json
  def show
    if Integer(params[:id]) < 0
      down_path = "#{Rails.root}/app/assets/resources/#{@resource_blog.file_path}"
      send_file  down_path unless down_path.blank?  
    else
      @resource_blog = ResourceBlog.find(params[:id])
      #show时点击数+1
      @resource_blog.click_count += 1
      @resource_blog.save
      @feed_items = @resource_blog.feed.paginate(page: params[:page]) 
    end
  end

  # GET /resource_blogs/new
  # 新建资源，记得传入已有的版块信息
  def new
    @resource_blog = ResourceBlog.new
    @all_tags = Tag.get_all_tags
  end

  # GET /resource_blogs/1/edit
  def edit
    @all_tags = Tag.get_all_tags
  end

  # POST /resource_blogs
  # POST /resource_blogs.json
  def create
    #@resource_blog = ResourceBlog.new(resource_blog_params)
    @all_tags = Tag.get_all_tags
    @resource_blog = current_user.resource_blogs.new(resource_blog_params)
    @resource_blog.response_count = 1
    @resource_blog.click_count = 0
    @resource_blog.accessment = 0
    unless request.get?
      #验证1：文件不能为空
      file = params[:resource_blog][:file_path]
      unless file
        flash.now[:danger] = "文件不能为空"
        render '/resource_blogs/new'
        return
      end
      #验证2：文件大小不能超过40MB
      if file.size > 40000000
        flash.now[:danger] = "文件不能大于40MB"
        render '/resource_blogs/new'
        return
      end
      #保存文件路径、文件名和大小
      filename = uploadfile(params[:resource_blog][:file_path])
      @resource_blog.file_path = filename
      file_size = file.size/1000000
      if Integer(file_size) == 0
        file_size = '<1MB'
      end
      @resource_blog.file_size = "#{file_size}MB"
    end
    #保存成功，转到文件所在页面
    if @resource_blog.save
      redirect_to "/resource_blogs/#{@resource_blog.id}"
    #否则，转到新建页面
    else
      render '/resource_blogs/new'
    end

  end

  # PATCH/PUT /resource_blogs/1
  # PATCH/PUT /resource_blogs/1.json
  def update
    respond_to do |format|
      if @resource_blog.update(resource_blog_params)
        format.html { redirect_to @resource_blog, notice: '文件已成功更新！' }
        format.json { render :show, status: :ok, location: @resource_blog }
      else
        format.html { render :edit }
        format.json { render json: @resource_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def uploadfile(file)
    @filename = file.original_filename
    @file_type = @filename.chomp.split(".")[-1]
     #设置目录路径，如果目录不存在，生成新目录
    FileUtils.mkdir("#{Rails.root}/app/assets/resources") unless File.exist?("#{Rails.root}/app/assets/resources")
     #写入文件
     ##wb 表示通过二进制方式写，可以保证文件不损坏
    File.open("#{Rails.root}/app/assets/resources/#{@filename}", "wb") do |f|
      f.write(file.read)
    end
    return @filename
  end

  # GET '/resource_blogs/down_file'
  def down_file
    down_path = "#{Rails.root}/app/assets/resources/#{params[:filename]}"
    send_file  down_path unless down_path.blank?   
  end  

  # DELETE /resource_blogs/1
  # DELETE /resource_blogs/1.json
  def destroy
    #检索回复，逐一删除
    ids = @resource_blog.resource_replys.collect{|x| x.reply.id} #some BUG with foreign key:(--zh
    @resource_blog.resource_replys.each{|x| x.destroy}
    ids.each{|id| Reply.find(id).destroy}
    @resource_blog.destroy
    respond_to do |format|
      format.html { redirect_to '/user_resources', notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  # POST /resource_blogs/1/reply
  def deal_reply
  #set_resource_blog 发表评论，计数+1
    @resource_blog.response_count += 1
  #@resource_blog.save
    @reply = Reply.create(send_user_id: current_user.id,receive_user_id: params[:receiver_id], content: params[:content]) 
    @resource_reply = @resource_blog.resource_replys.new
    @resource_reply.reply_id = @reply.id
    #评论字数限制
    if params[:content].length<2 or params[:content].length>50
      flash[:danger] = "回复长度必须在2-50字"
    end
    if @resource_blog.save
      flash[:success] = "发表成功"
    else
      flash[:danger] = "发表失败"
    end
    redirect_to "/resource_blogs/#{@resource_blog.id}"
  end

  # GET '/resource_blogs/tags/:id'
  def show_tag
    @resource_blogs = ResourceBlog.where("tag_id = ?", params[:id])
    @tags = Tag.all
    @tag_id = params[:id].to_i
    @tag_name = Tag.find(params[:id]).name
  end
  private
    #用户已登录确认
    def ensure_logged_in
      unless logged_in?
        store_forwarding_url
        flash[:warning] = "请先登录！"
        redirect_to login_url
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_blog
      if Integer(params[:id]) < 0
        real_id = Integer(params[:id]) * -1
        @resource_blog = ResourceBlog.find(real_id.to_s)
      else
        @resource_blog = ResourceBlog.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def resource_blog_params
      params.require(:resource_blog).permit(:title, :tag_id, :content, :file_path)
    end
end

