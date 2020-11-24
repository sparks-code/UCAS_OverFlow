class FileTransfersController < ApplicationController
  before_action :set_file_transfer, only: [:show, :edit, :update, :destroy]

  # GET /file_transfers
  # GET /file_transfers.json
  def index
    @file_transfers = FileTransfer.all
  end

  # GET /file_transfers/1
  # GET /file_transfers/1.json
  def show
  end

  # GET /file_transfers/new
  def new
    @file_transfer = FileTransfer.new
  end

  # GET /file_transfers/1/edit
  def edit
  end

  # POST /file_transfers
  # POST /file_transfers.json
  def create
    @file_transfer = FileTransfer.new(file_transfer_params)

    respond_to do |format|
      if @file_transfer.save
        format.html { redirect_to @file_transfer, notice: 'File transfer was successfully created.' }
        format.json { render :show, status: :created, location: @file_transfer }
      else
        format.html { render :new }
        format.json { render json: @file_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /file_transfers/1
  # PATCH/PUT /file_transfers/1.json
  def update
    respond_to do |format|
      if @file_transfer.update(file_transfer_params)
        format.html { redirect_to @file_transfer, notice: 'File transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @file_transfer }
      else
        format.html { render :edit }
        format.json { render json: @file_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_transfers/1
  # DELETE /file_transfers/1.json
  def destroy
    @file_transfer.destroy
    respond_to do |format|
      format.html { redirect_to file_transfers_url, notice: 'File transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_transfer
      @file_transfer = FileTransfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def file_transfer_params
      params.require(:file_transfer).permit(:file_path, :introduction)
    end
end
