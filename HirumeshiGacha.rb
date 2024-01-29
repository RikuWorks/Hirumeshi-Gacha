require 'sinatra'
require 'yaml/store'
get '/' do
    @title = 'Hirumeshi-Gacha'
    erb :index
end

post '/cast' do
    @title = 'Thanks for casting your vote!'
    @vote  = params['vote']
    @store = YAML::Store.new 'votes.yaml'
    @store.transaction do
      @store['votes'] ||= {}
      @store['votes'][@vote] ||= 0
      @store['votes'][@vote] += 1
    end
    erb :cast
  end
  
  get '/results' do
    @title = 'Results so far:'
    @store = YAML::Store.new 'votes.yaml'
    @votes = @store.transaction { @store['votes'] }
    erb :results
  end
Choices = {
  'EGG' => 'たまごフィルタ',
  'SEA' => '海鮮フィルタ',
  'BOU' => 'ブルジョアジーフィルタ',
  'JNK' => 'ジャンキーフィルタ',
}