Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/tf-idf/document/add', to: "tf_idf/document#add"
      delete '/tf-idf/document/remove', to: "tf_idf/document#remove"
      post '/tf-idf/document/term-scores', to: "tf_idf/document#update_term_scores"
      get '/tf-idf/document/term-scores', to: "tf_idf/document#get_term_scores"
    end
  end
end
