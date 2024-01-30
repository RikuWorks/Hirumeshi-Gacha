require 'sinatra'
require 'yaml/store'
get '/' do
    @title = 'Hirumeshi-Gacha'
    erb :index
end

post '/gacha' do
    @title = 'Todays Hirumeshi'
    p params['EGG']
    p params['SEA']
    p params['BOU']
    p params['JNK']
    erb :gacha
  end

Choices = {
  'EGG' => 'たまごフィルタ',
  'SEA' => '海鮮フィルタ',
  'BOU' => 'ブルジョアジーフィルタ',
  'JNK' => 'ジャンキーフィルタ',
}