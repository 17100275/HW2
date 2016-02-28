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
    x=params[:ratings]
#    puts "#{x.keys} fkals;dkf;lasdk;flaksdl;"

    @ratings = x.keys
    @all_ratings = ['G','PG','PG-13','R']
    @highlightt = 'nothing'
    @highlightd = 'nothing'
    
    if x
      @movies = Movie.where("rating IN (?)", @ratings)

    ## sorting lists
    elsif (params[:sort_by] == "title")
      @highlightt= 'hilite'
      @highlightd = 'nothing'
      @movies = Movie.order(params[:sort_by])
    else (params[:sort_by] == "release_date" && !params[:sort_by].empty?)
      @highlightd= 'hilite'
      @highlightt = 'nothing'
      @movies = Movie.order(params[:sort_by])
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
