module Api
  module V1
    class ArticlesController < ApplicationController
      def index
	articles = Article.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Artigos carregados', data: articles}, status: :ok
      end
    
      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCES', message: 'Loaded article', data: article}, status: :ok
      end

      def created 
        article = Article.new(article_params)
        if article.save
          render json: { status: 'SUCCESS', message: 'Articles not saved', data: article}, status: :ok
        else
        	render json: { status: 'ERROR', message: 'Articles not saved', data: article.erros}, status: :unprocessable_entity
        end
      end

      def destroy
      	article = Article.find(params[:id])
      	article.destroy
      	render json: {status: 'SUCCESS', message: 'Deletede article', data: article.erros}, status: :ok
      end

      def update
      	article = Article.find(params[:id])
      	if article.update_attributes(article_params)
      		render json: {status: 'SUCCESS', message: 'Updated article', data: article}, status: :ok
      	else
      		render json: {status: 'ERROR', message: 'Articles not update', data: article.error}, status: :unprocessable_entity
      	end
      end

      private
      	def article_params
      		params.permit(:title, :body)
    		end
    end
  end
end
