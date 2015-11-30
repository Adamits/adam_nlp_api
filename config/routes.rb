Rails.application.routes.draw do
  devise_for :users
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        post '/tf_idf/document/add', to: "tf_idf/document#add"
        delete '/tf_idf/document/remove', to: "tf_idf/document#remove"
        post '/tf_idf/document/term_scores', to: "tf_idf/document#term_scores"
      end
    end
  end
end
