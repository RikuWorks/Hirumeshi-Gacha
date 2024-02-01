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
  sql_process = "SELECT shop FROM hirumeshi WHERE"
  egg_process = " egg=false AND "
  seafood_process = " seafood=false AND "
  bourgeois_process = " bourgeois=false AND "
  junky_process = " junky=false AND "
  shop_process = " shop!=''"

  egg = params['EGG']
  seafood = params['SEA']
  bourgeois = params['BOU']
  junky = params['JNK']
  if egg
    sql_process = sql_process + egg_process
  end
  if seafood
    sql_process = sql_process + seafood_process
  end
  if bourgeois
    sql_process = sql_process + bourgeois_process
  end
  if junky
    sql_process = sql_process + junky_process
  end
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
