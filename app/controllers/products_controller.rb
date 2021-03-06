
class ProductsController < ApplicationController


  def index
 #   @products = Product.find_with_reputation(:votes, :all, order: "votes desc")
      @products = Product.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end


  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    @comment =  Comment.find(:all, :conditions => {:product_id =>@product.id})
    @questions =  Question.find(:all, :conditions => {:product_id =>@product.id})
    @answer =  Answer.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def show_user_products
    @products =  Product.find(:all, :conditions => {:user_id =>current_user.id})
    @questions = Question.find(:all)
    @answers = Answer.find(:all)
    @comments= Comment.find(:all)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end


  def new
    @product = Product.new
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @comment =  Comment.find(:all, :conditions => {:product_id =>@product.id})
    @question =  Question.find(:all, :conditions => {:product_id =>@product.id})
    @answer =  Answer.find(:all, :conditions => {:question_id =>@product.id})
 end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    @product.user_id=current_user.id

    respond_to do |format|
      if @product.save
        format.html { redirect_to root_path, notice: 'Product was successfully created.' }
        #    format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])


    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to edit_product_path(@product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def vote
   #value = params[:type] == "up" ? 1 : -1
    case params[:type]
      when "up"
        value=1
      when"down"
        value=-1

    end   # end case


   @product = Product.find(params[:id])
   @product.add_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end



  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
