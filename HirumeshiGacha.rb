require 'sinatra'
get '/' do
    @title = 'Hirumeshi-Gacha'
    erb :index
end

post '/gacha' do
    meshiList = [["A", "1", "0","0","0"], ["B", "0", "1","0","0"],["C", "0", "0","1","0"],["D", "0", "0","0","1"]]
    nmeshiList=[]
    @title = 'Todays Hirumeshi'
    egg = params['EGG']
    seafood = params['SEA']
    bourgeois = params['BOU']
    junky = params['JNK']
    filter = [egg.to_i,seafood.to_i,bourgeois.to_i,junky.to_i]
    p filter
    meshiList.each do |p_a|
      tf = p_a[1].to_i*filter[0]+p_a[2].to_i*filter[1]+p_a[3].to_i*filter[2]+p_a[4].to_i*filter[3]
      if tf==0 then
        nmeshiList.push(p_a)
      end
    end
    p nmeshiList
    list_size = nmeshiList.size
    p list_size
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
