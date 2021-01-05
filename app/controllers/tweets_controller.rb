class TweetsController < ApplicationController

    get '/tweets' do
        redirect_if_not_logged_in
        @tweets = Tweet.all
        erb :"/tweets/index"
    end

    get '/tweets/new' do
        redirect_if_not_logged_in
        erb :'/tweets/new'
    end

    post '/tweets' do
        redirect_if_not_logged_in
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets/new'
        end

    end

    get '/tweets/:id' do
        redirect_if_not_logged_in
        @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do
        redirect_if_not_logged_in
        @tweet = current_user.tweets.find_by(id: params[:id])
        if @tweet
            erb :'/tweets/edit'
        else
            redirect "/tweets"
        end
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find_by(id: params[:id])
        @tweet.update(content: params[:content])
        if @tweet.valid?
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
        
    end






    delete '/tweets/:id' do
        redirect_if_not_logged_in
        if params[:content] != ""
            @tweet = current_user.tweets.find_by(id: params[:id])
            if @tweet
                @tweet.destroy
                redirect "/tweets"
            else
                redirect "/tweets"
            end
        end
    end
end
