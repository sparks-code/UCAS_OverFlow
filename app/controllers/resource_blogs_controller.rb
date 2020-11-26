class ResourceBlogsController < ApplicationController
  before_action :set_resource_blog, only: [:show, :edit, :update, :destroy]
    include SessionsHelper
  # GET /resource_blogs
  # GET /resource_blogs.json
  def index
    @resource_blogs = ResourceBlog.all
  end

  # GET /resource_blogs/1
  # GET /resource_blogs/1.json
  def show
    @resource_blog = ResourceBlog.find(params[:id])
    @resource_blog.click_count += 1
    @resource_blog.save
  end

  # GET /resource_blogs/new
  def new
    @resource_blog = ResourceBlog.new
  end

  # GET /resource_blogs/1/edit
  def edit
  end

  # POST /resource_blogs
  # POST /resource_blogs.json
  def create
    #@resource_blog = ResourceBlog.new(resource_blog_params)
    @resource_blog = current_user.resource_blogs.new(resource_blog_params)
    @resource_blog.response_count = 0
    @resource_blog.click_count = 0
    resource_blog.accessment = 0
    unless request.get?
      filename = uploadfile(params[:resource_blog][:file_path])
      @resource_blog.filepath = filename
    end
    if @resource_blog.save
      redirect_to "/resource_blogs/#{@resource_blog.id}"
    else
      render '/resource_blogs/new'
    end
    # respond_to do |format|
    #   if @resource_blog.save
    #     format.html { redirect_to @resource_blog, notice: 'Resource blog was successfully created.' }
    #     format.json { render :show, status: :created, location: @resource_blog }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @resource_blog.errors, status: :unprocessable_entity }
    #   end
    # end
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
    errors.add("", "文件为空") if @filename.empty?
     #设置目录路径，如果目录不存在，生成新目录
    FileUtils.mkdir("#{Rails.root}/app/assets/resources") unless File.exist?("#{Rails.root}/app/assets/resources")
     #写入文件
     ##wb 表示通过二进制方式写，可以保证文件不损坏
    File.open("#{Rails.root}/app/assets/resources/#{@filename}", "wb") do |f|
      f.write(file.read)
    end
    return @filename
  end

  def down_file
 
    send_file "#{Rails.root}/app/assets/resources/"+params[:filename] unless params[:filename].blank?  
 
  end  

  # DELETE /resource_blogs/1
  # DELETE /resource_blogs/1.json
  def destroy
    @resource_blog.destroy
    respond_to do |format|
      format.html { redirect_to resource_blogs_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_blog
      @resource_blog = ResourceBlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resource_blog_params
      params.require(:resource_blog).permit(:title, :tag)
    end
end
