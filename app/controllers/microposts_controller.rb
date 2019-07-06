class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy


  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    id = params[:id]
		@micropost = Micropost.find(id)
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
    id = params[:id]
		@micropost = Micropost.find(id)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
        @feed_items = []
      render 'static_pages/home'
    end
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = Micropost.new(micropost_params)

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html { render :new }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    def correct_user
          @micropost = current_user.microposts.find_by(id: params[:id])
          redirect_to root_url if @micropost.nil?
        end

    def micropost_params
        params.require(:micropost).permit(:content, :picture)
    end
end
