class ResourceBlogsController < ApplicationController
  before_action :set_resource_blog, only: [:show, :edit, :update, :destroy]

  # GET /resource_blogs
  # GET /resource_blogs.json
  def index
    @resource_blogs = ResourceBlog.all
  end

  # GET /resource_blogs/1
  # GET /resource_blogs/1.json
  def show
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
    @resource_blog = ResourceBlog.new(resource_blog_params)

    respond_to do |format|
      if @resource_blog.save
        format.html { redirect_to @resource_blog, notice: 'Resource blog was successfully created.' }
        format.json { render :show, status: :created, location: @resource_blog }
      else
        format.html { render :new }
        format.json { render json: @resource_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_blogs/1
  # PATCH/PUT /resource_blogs/1.json
  def update
    respond_to do |format|
      if @resource_blog.update(resource_blog_params)
        format.html { redirect_to @resource_blog, notice: 'Resource blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource_blog }
      else
        format.html { render :edit }
        format.json { render json: @resource_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_blogs/1
  # DELETE /resource_blogs/1.json
  def destroy
    @resource_blog.destroy
    respond_to do |format|
      format.html { redirect_to resource_blogs_url, notice: 'Resource blog was successfully destroyed.' }
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
      params.require(:resource_blog).permit(:title, :tag, :response_count, :click_count, :accessment, :user_id, :file_transfer_id)
    end
end
