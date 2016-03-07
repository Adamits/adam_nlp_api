Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/tf_idf/document/add', to: "tf_idf/document#add"
      delete '/tf_idf/document/remove', to: "tf_idf/document#remove"
      post '/tf_idf/document/term_scores', to: "tf_idf/document#update_term_scores"
      get '/tf_idf/document/term_scores', to: "tf_idf/document#get_term_scores"
    end
  end
end
