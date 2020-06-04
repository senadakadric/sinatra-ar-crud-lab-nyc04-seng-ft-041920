
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    # binding.pry
    # params => {"title"=>"my favorite article", "content"=>"content!!!!"
    @new_article = Article.create(params)

    redirect "/articles/#{@new_article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    #to be able to show a form to edit a specific article, we have to find that instance of the article which corresponds to the id in the URL and save it into an instance variable to be able to use it in erb: edit
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    #to then edit an existing article, we need to find the instance and update it with the params that we are getting from the form
    # binding.pry

    @article = Article.find(params[:id])

    @article.update(params[:article])

    redirect "/articles/#{@article.id}"
  end


  delete '/articles/:id' do
    #we need to find the instance of the article w/ the corresponding ID to delete it
    @article = Article.find(params[:id])

    @article.destroy

    redirect '/articles'
  end


end
