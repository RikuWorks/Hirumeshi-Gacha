require 'sinatra'
require 'pg' 

def conn
  @conn ||= PG.connect(dbname: 'postgres')
end

configure do
  result = conn.exec("SELECT * FROM information_schema.tables WHERE table_name = 'hirumeshi'")
  conn.exec('CREATE TABLE hirumeshi (shop varchar(255), egg boolean,seafood boolean,bourgeois boolean,junky boolean)') if result.values.empty?
  #conn.exec("INSERT INTO hirumeshi VALUES ('A',true,false,false,false);")
end

get '/' do
  @title = 'Hirumeshi-Gacha'
  erb :index
end

post '/gacha' do
  sql_process = "SELECT shop FROM hirumeshi WHERE "
  egg_process = " egg=false AND "
  seafood_process = " seafood=false AND "
  bourgeois_process = " bourgeois=false AND "
  junky_process = " junky=false AND "
  shop_process = " shop!=''"
  
  sql_process = sql_process + egg_process if params['EGG']
  sql_process = sql_process + seafood_process if params['SEA']
  sql_process = sql_process + bourgeois_process if params['BOU']
  sql_process = sql_process + junky_process if params['JNK']
  sql_process = sql_process + shop_process
  meshiList = conn.exec(sql_process)
  
  @title = 'Todays Hirumeshi'
  nmeshiList = meshiList.values
  list_size = nmeshiList.size
  meshi = rand(list_size)
  @meshi = nmeshiList[meshi][0]
  erb :gacha
end
CHOICES = {
  'EGG' => 'たまごフィルタ',
  'SEA' => '海鮮フィルタ',
  'BOU' => 'ブルジョアジーフィルタ',
  'JNK' => 'ジャンキーフィルタ',
}
