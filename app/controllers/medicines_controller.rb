class MedicinesController < ApplicationController
  before_action :require_user
  before_action :set_medicine, only: [:show, :edit, :update, :destroy]
  require 'date'
  # GET /medicines
  # GET /medicines.json
  def index
    #@medicines = Medicine.all
    @medicines = current_user.medicines
    if params[:search]
    @medicines = @medicines.search(params[:search]).order("created_at DESC")
   else
    @medicines = current_user.medicines
   end
   @exp_medicine = Medicine.where("expiry_date > ? And expiry_date < ? && user_id = ?",Date.today - 2.days,Date.today + 2,current_user.id)
   UserMailer.send_report(@exp_medicine).deliver if @exp_medicine.present?

   #@medicines.each do |med|
    #  expiry_date_diff = (med.expiry_date.to_date - Date.today).to_i
     #    if expiry_date_diff <= 2  
     #end
   #end 
 end

 

  # GET /medicines/1
  # GET /medicines/1.json
  def show
  end

  # GET /medicines/new
  def new
    @medicine = Medicine.new
  end

  # GET /medicines/1/edit
  def edit
  end

  # POST /medicines
  # POST /medicines.json
  def create
    @medicine = Medicine.new(medicine_params.merge!({:user_id => current_user.id}))

    respond_to do |format|
      if @medicine.save
        format.html { redirect_to @medicine, notice: 'Medicine was successfully created.' }
        format.json { render :show, status: :created, location: @medicine }
      else
        format.html { render :new }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicines/1
  # PATCH/PUT /medicines/1.json
  def update
    respond_to do |format|
      if @medicine.update(medicine_params.merge!({:user_id => current_user.id}))
        format.html { redirect_to @medicine, notice: 'Medicine was successfully updated.' }
        format.json { render :show, status: :ok, location: @medicine }
      else
        format.html { render :edit }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicines/1
  # DELETE /medicines/1.json
  def destroy
    @medicine.destroy
    respond_to do |format|
      format.html { redirect_to medicines_url, notice: 'Medicine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medicine_params
      params.require(:medicine).permit(:name, :quantity, :selling_quantity, :expiry_date, :price)
    end
end
