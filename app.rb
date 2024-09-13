require 'sinatra'
require 'json'
require 'sinatra/cors'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*' 
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options, :head],
      credentials: false
  end
end

get '/' do
  content_type :json
  { message: 'Sound Menory API!' }.to_json
end

  months = [
    { id: 1, name: '一月', img: 'https://meee.com.tw/HlI4HUH.jpg', audio: 'https://meee.ing/b23b74' },
    { id: 2, name: '二月', img: 'https://meee.com.tw/y1y9eJx.jpg' },
    {id: 3, name: '三月', img: 'https://i.meee.com.tw/bVfJrSL.jpg'},
    {id: 4, name: '四月', img: 'https://meee.com.tw/IPRxxNr.jpg'},
    {id: 5, name: '五月', img: 'https://meee.com.tw/N935k8U.jpg'},
    {id: 6, name: '六月', img: 'https://meee.com.tw/1LCtucB.jpg'},
    {id: 7, name: '七月', img: 'https://meee.com.tw/crejJwT.jpg'},
    {id: 8, name: '八月', img: 'https://meee.com.tw/WbBfbG7.jpg'},
    {id: 9, name: '九月', img: 'https://meee.com.tw/hpqdTzM.jpg'},
    {id: 10, name: '十月', img: 'https://meee.com.tw/0uVHhEM.jpg'},
    {id: 11, name: '十一月', img: 'https://meee.com.tw/DEDzPaG.jpg'},
    {id: 12, name: '十二月', img: 'https://meee.com.tw/SmrjCtN.jpg'}
  ]
get '/months/list' do
  content_type :json
  months.to_json
end

set :public_folder, 'public'

AUDIO_DIR = File.expand_path('../public/audio', __FILE__)


get '/audio/:file' do
  file_name = params['file'] + '.mp3'
  file_path = File.join(AUDIO_DIR, file_name)

  if File.exist?(file_path)
    send_file file_path, type: 'audio/mpeg', disposition: 'inline'
  else
    halt 404, { error: 'File not found' }.to_json.force_encoding('UTF-8')
  end
end
