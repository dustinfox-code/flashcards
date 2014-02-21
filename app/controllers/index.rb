get '/' do

  erb :index
end


post '/login' do

end


post '/logout' do

end


get '/round/new/?' do
  @decks = Deck.all
  erb :new_round
end

post '/round/create' do
  @deck = Deck.find(params[:deck_id].to_i)
  @deck_id = @deck.id
  Round.create(deck_id: @deck_id, user_id: 1) #session[:user_id])
  session[:cards] = @deck.cards
  redirect to("/round/#{session[:cards].shuffle.pop.id}")
end

# get '/round/:card_id/?' do
#   @current_card = Card.find(params[:card_id].to_i)
#   @prompt = @current_card.question
#   @answer = @current_card.answer
# end

get '/round/next' do
  redirect to("/round/#{session[:cards].shuffle.pop.id}")
end

get '/round/:card_id/?' do
  @current_card = Card.find(params[:card_id].to_i)
  erb :question
end

post '/round/:card_id/outcome' do
  @guess = params[:answer]
  @answer = Card.find(params[:card_id].to_i).answer
  @outcome = "Sorry, the correct answer is #{@answer}."
  @outcome = "Nice job Walrus" if @answer == @guess
  erb :result
end

get '/round/complete/?' do

end



