# -*- encoding : utf-8 -*-
#encoding: utf-8

class PicturesController < ApplicationController


protect_from_forgery :except => :create

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create

    newparams = coerce(params)
    # @upload = Upload.new(newparams[:upload])

    # p_attr = []
    
    # p_attr[:image] = params[:Filedata][:filename].first if params[:Filedata][:filename].class == Array
    # p_attr = params[:Filename].to_s


    # @picture = Picture.new(:image => 'paris.jpg')
    # newparams[:picture][:image].inspect

    # image_filename = URI.unescape(newparams[:picture][:image])
    # @picture = Picture.new(URI.unescape(newparams[:picture]))

    @picture = Picture.new(newparams[:picture])

    respond_to do |format|
      if @picture.save
        # format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        # format.js { @picture.id }
        return  true
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  def get_thumb
    # temp_filename = params[:file]
    # filename = string = CGI::unescape(temp_filename)
    file = Picture.find_by_image(params[:file])
    respond_to do |format|
        format.json { render json: {:id => file.id, :thumb => file.image.thumb.url} }
    end    
  end

  private 
  def coerce(params)
    if params[:picture].nil? 
      h = Hash.new 
      h[:picture] = Hash.new       
      h[:picture][:image] = params[:Filedata] 
      # h[:picture][:image].content_type = MIME::Types.type_for(h[:picture][:image].original_filename).to_s
      h
    else 
      params
    end 
  end

end
