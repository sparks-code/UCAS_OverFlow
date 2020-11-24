class TextBlogsController < ApplicationController
  before_action :set_text_blog, only: [:show, :edit, :update, :destroy]

  # GET /text_blogs
  # GET /text_blogs.json
  def index
    @text_blogs = TextBlog.all
  end

  # GET /text_blogs/1
  # GET /text_blogs/1.json
  def show
  end

  # GET /text_blogs/new
  def new
    @text_blog = TextBlog.new
  end

  # GET /text_blogs/1/edit
  def edit
  end

  # POST /text_blogs
  # POST /text_blogs.json
  def create
    @text_blog = TextBlog.new(text_blog_params)

    respond_to do |format|
      if @text_blog.save
        format.html { redirect_to @text_blog, notice: 'Text blog was successfully created.' }
        format.json { render :show, status: :created, location: @text_blog }
      else
        format.html { render :new }
        format.json { render json: @text_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_blogs/1
  # PATCH/PUT /text_blogs/1.json
  def update
    respond_to do |format|
      if @text_blog.update(text_blog_params)
        format.html { redirect_to @text_blog, notice: 'Text blog was successfully updated.' }
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
    @text_blog.destroy
    respond_to do |format|
      format.html { redirect_to text_blogs_url, notice: 'Text blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_blog
      @text_blog = TextBlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def text_blog_params
      params.require(:text_blog).permit(:title, :tag, :content, :response_count, :click_count, :accessment, :user_id, :file_transfer_id)
    end
end
