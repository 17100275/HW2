class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end



  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

#################################################################################update
  def up
    #@movie = Movie.find params[:id]
  end
  
  def up2
    x=params.require(:movie).permit(:title1,:title, :rating, :release_date)
    
    title1=x[:title1]
    title=x[:title]
    rating=x[:rating]
    release_date=x[:release_date]
    
    @movie=Movie.find_by title: title1
#    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
#    puts "#{x} dlkfal;sdkfl;askdl;fkal;sdklf;askld;fkl;askdl;fkal;s"
    
    if @movie
      #@movie.update_attributes!(movie_params)
      if title != ""
        @movie.update_attribute(:title,title)
      end
      if rating != ""
        @movie.update_attribute(:rating,rating)
      end
      if release_date != ""
        @movie.update_attribute(:release_date,release_date)
      end
      redirect_to movie_path(@movie)
      return
    end
#    redirect_to movies_path  
  end
  
################################################################################update
################################################################################delete
  def del
    
  end
  def del2
    x=params.require(:movie).permit(:title, :rating)
    title=x[:title]
    rating=x[:rating]
    if title != nil
      @movie = Movie.find_by title: title
      @movie.destroy
      redirect_to movies_path

    elsif rating != nil
    #  puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      Movie.where(rating: rating).each {|k| k.destroy }
      redirect_to movies_path

    end
  end

################################################################################delete

################################################################################index
  def index
#    x=params[:ratings]
#    puts "#{x.keys} fkals;dkf;lasdk;flaksdl;"
    
    @all_ratings = ['G','PG','PG-13','R']
    @highlightt = 'nothing'
    @highlightd = 'nothing'
 
    
    if params[:ratings]
      session[:r] = params[:ratings]
    end
    
    if params[:sort_by]
      session[:s] = params[:sort_by]
    end

    x=session[:r]
    x2=session[:s]
    
       
    if x && x2
      if x2=='title'
        
        @highlightt= 'hilite'
        @highlightd = 'nothing'
      elsif x2=='release_date'
        @highlightd= 'hilite'
        @highlightt = 'nothing'
      end
        
      @ratings = x.keys
      @movies = Movie.where("rating IN (?)", @ratings).order(x2) 
      
    elsif x
      @ratings = x.keys
      @movies = Movie.where("rating IN (?)", @ratings)

    ## sorting lists
    elsif (x2 == "title")
      @highlightt= 'hilite'
      @highlightd = 'nothing'
      @movies = Movie.order(x2)
    else (x2 == "release_date" && !x2.empty?)
      @highlightd= 'hilite'
      @highlightt = 'nothing'
      @movies = Movie.order(x2)
    end
#    @movies = Movie.all
  end
################################################################################index




  def new

    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
