class DbaliasesController < ApplicationController
  # GET /dbaliases
  # GET /dbaliases.xml
  def index
    @dbaliases = Dbalias.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dbaliases }
    end
  end

  # GET /dbaliases/1
  # GET /dbaliases/1.xml
  def show
    @dbalias = Dbalias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dbalias }
    end
  end

  # GET /dbaliases/new
  # GET /dbaliases/new.xml
  def new
    @dbalias = Dbalias.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dbalias }
    end
  end

  # GET /dbaliases/1/edit
  def edit
    @dbalias = Dbalias.find(params[:id])
  end

  # POST /dbaliases
  # POST /dbaliases.xml
  def create
    @dbalias = Dbalias.new(params[:dbalias])

    respond_to do |format|
      if @dbalias.save
        format.html { redirect_to(@dbalias, :notice => 'Dbalias was successfully created.') }
        format.xml  { render :xml => @dbalias, :status => :created, :location => @dbalias }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dbalias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dbaliases/1
  # PUT /dbaliases/1.xml
  def update
    @dbalias = Dbalias.find(params[:id])

    respond_to do |format|
      if @dbalias.update_attributes(params[:dbalias])
        format.html { redirect_to(@dbalias, :notice => 'Dbalias was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dbalias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dbaliases/1
  # DELETE /dbaliases/1.xml
  def destroy
    @dbalias = Dbalias.find(params[:id])
    @dbalias.destroy

    respond_to do |format|
      format.html { redirect_to(dbaliases_url) }
      format.xml  { head :ok }
    end
  end
end
